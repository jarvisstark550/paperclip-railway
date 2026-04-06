#!/usr/bin/env node
/**
 * Export Paperclip database from local embedded Postgres to SQL dump
 * Usage: node scripts/export-database.js
 */

import postgres from 'postgres';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function exportDatabase() {
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
  const outputFile = path.join(__dirname, `../database-export-${timestamp}.sql`);

  console.log('🚀 Starting database export...');
  console.log(`   From: embedded Postgres at localhost:54329`);
  console.log(`   To: ${outputFile}`);

  try {
    // Connect to the embedded Postgres instance
    const sql = postgres({
      host: 'localhost',
      port: 54329,
      database: 'paperclip',
      username: 'paperclip',
      password: 'paperclip',
      ssl: false,
    });

    // Get all tables
    const tables = await sql`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `;

    console.log(`\n📋 Found ${tables.length} tables to export`);

    let sqlDump = `-- Paperclip Database Export\n-- Generated: ${new Date().toISOString()}\n\n`;

    // Export schema and data for each table
    for (const { table_name } of tables) {
      console.log(`   Exporting table: ${table_name}...`);

      // Get CREATE TABLE statement
      const createTableResult = await sql.unsafe(
        `SELECT pg_get_createtablestmt('${table_name}'::regclass);`
      );

      if (createTableResult?.[0]) {
        sqlDump += `\n${createTableResult[0].pg_get_createtablestmt}\n\n`;
      }

      // Get data
      const rows = await sql.unsafe(`SELECT * FROM "${table_name}";`);
      
      if (rows.length > 0) {
        const columns = Object.keys(rows[0]);
        sqlDump += `INSERT INTO "${table_name}" (${columns.map(c => `"${c}"`).join(', ')}) VALUES\n`;
        
        rows.forEach((row, idx) => {
          const values = columns.map(col => {
            const val = row[col];
            if (val === null) return 'NULL';
            if (typeof val === 'string') return `'${val.replace(/'/g, "''")}'`;
            if (typeof val === 'object') return `'${JSON.stringify(val).replace(/'/g, "''")}'`;
            return val;
          });
          sqlDump += `(${values.join(', ')})${idx < rows.length - 1 ? ',' : ';'}\n`;
        });
        sqlDump += '\n';
      }
    }

    // Write to file
    fs.writeFileSync(outputFile, sqlDump, 'utf-8');
    
    await sql.end();

    console.log(`\n✅ Export complete!`);
    console.log(`   File size: ${(fs.statSync(outputFile).size / 1024 / 1024).toFixed(2)} MB`);
    console.log(`   Tables exported: ${tables.length}`);
    console.log(`\n📝 Next steps:`);
    console.log(`   1. Create Railway Postgres database`);
    console.log(`   2. Import this SQL file to Railway`);
    console.log(`   3. Update DATABASE_URL in Railway environment`);
    
  } catch (error) {
    console.error('\n❌ Export failed:', error.message);
    process.exit(1);
  }
}

exportDatabase();
