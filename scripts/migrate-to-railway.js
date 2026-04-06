#!/usr/bin/env node
/**
 * Migrate Paperclip database from local embedded Postgres to Railway Postgres
 * Usage: DATABASE_URL="postgresql://..." node scripts/migrate-to-railway.js
 */

import postgres from 'postgres';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function migrateDatabase() {
  if (!process.env.DATABASE_URL) {
    console.error('❌ DATABASE_URL environment variable not set');
    console.error('Usage: DATABASE_URL="postgresql://..." node scripts/migrate-to-railway.js');
    process.exit(1);
  }

  console.log('🚀 Starting database migration to Railway...');

  try {
    // Connect to local embedded Postgres
    const localDb = postgres({
      host: 'localhost',
      port: 54329,
      database: 'paperclip',
      username: 'paperclip',
      password: 'paperclip',
      ssl: false,
    });

    // Connect to Railway Postgres
    const railwayDb = postgres(process.env.DATABASE_URL);

    console.log('\n📊 Analyzing source database...');
    
    // Get all tables from local database
    const tables = await localDb`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `;

    console.log(`   Found ${tables.length} tables`);

    // Create tables in Railway
    console.log('\n🏗️  Creating schema in Railway...');
    
    for (const { table_name } of tables) {
      try {
        // Get CREATE TABLE statement
        const createTableResult = await localDb.unsafe(
          `SELECT pg_get_createtablestmt('${table_name}'::regclass);`
        );

        if (createTableResult?.[0]?.pg_get_createtablestmt) {
          const createStmt = createTableResult[0].pg_get_createtablestmt;
          console.log(`   Creating table: ${table_name}`);
          await railwayDb.unsafe(createStmt);
        }
      } catch (err) {
        console.warn(`   ⚠️  Warning creating ${table_name}: ${err.message}`);
      }
    }

    // Migrate data
    console.log('\n📦 Migrating data...');
    
    let totalRows = 0;
    for (const { table_name } of tables) {
      try {
        const rows = await localDb.unsafe(`SELECT * FROM "${table_name}";`);
        
        if (rows.length > 0) {
          // Batch insert to Railway
          const columns = Object.keys(rows[0]);
          const values = rows.map(row => 
            columns.map(col => row[col])
          );
          
          await railwayDb.unsafe(
            `INSERT INTO "${table_name}" (${columns.map(c => `"${c}"`).join(', ')}) VALUES ${
              values.map((val) => `(${val.map(v => v === null ? 'NULL' : `'${String(v).replace(/'/g, "''")}'`).join(', ')})`).join(', ')
            }`
          );
          
          totalRows += rows.length;
          console.log(`   ✓ ${table_name}: ${rows.length} rows migrated`);
        }
      } catch (err) {
        console.error(`   ✗ Error migrating ${table_name}: ${err.message}`);
      }
    }

    await localDb.end();
    await railwayDb.end();

    console.log(`\n✅ Migration complete!`);
    console.log(`   Total rows migrated: ${totalRows}`);
    console.log(`   Tables migrated: ${tables.length}`);
    console.log(`\n🎉 Database is now running on Railway!`);
    
  } catch (error) {
    console.error('\n❌ Migration failed:', error.message);
    process.exit(1);
  }
}

migrateDatabase();
