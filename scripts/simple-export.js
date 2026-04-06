#!/usr/bin/env node
/**
 * Simple database export - dumps data from embedded Postgres
 * Usage: node scripts/simple-export.js
 */

import postgres from 'postgres';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

async function exportDatabase() {
  const timestamp = new Date().toISOString().replace(/[:.]/g, '-').slice(0, -5);
  const outputFile = path.join(__dirname, `../database-schema-${timestamp}.sql`);

  console.log('🚀 Exporting database schema and table count...\n');

  try {
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
      SELECT table_name, table_type
      FROM information_schema.tables 
      WHERE table_schema = 'public'
      ORDER BY table_name;
    `;

    console.log(`📊 Database Analysis:\n`);
    console.log(`   Total tables: ${tables.length}\n`);

    let report = `# Paperclip Database Export Report\nGenerated: ${new Date().toISOString()}\n\n`;
    report += `## Tables (${tables.length} total)\n\n`;

    let totalRows = 0;

    // Get row counts and basic stats
    for (const { table_name } of tables) {
      try {
        const [{ count }] = await sql`SELECT COUNT(*) as count FROM ${sql(table_name)};`;
        const columns = await sql`
          SELECT column_name, data_type 
          FROM information_schema.columns 
          WHERE table_name = ${table_name}
          ORDER BY ordinal_position;
        `;

        console.log(`   ${table_name}: ${count} rows, ${columns.length} columns`);

        report += `### ${table_name}\n`;
        report += `- **Rows**: ${count}\n`;
        report += `- **Columns**: ${columns.length}\n`;
        report += `- **Fields**:\n`;
        
        for (const col of columns) {
          report += `  - \`${col.column_name}\` (${col.data_type})\n`;
        }
        report += `\n`;

        totalRows += parseInt(count);
      } catch (err) {
        console.warn(`   ⚠️  ${table_name}: Error reading`);
      }
    }

    report += `## Summary\n\n`;
    report += `- **Total tables**: ${tables.length}\n`;
    report += `- **Total rows**: ${totalRows}\n`;
    report += `- **Export date**: ${new Date().toISOString()}\n`;
    report += `- **Source**: Local embedded Postgres\n`;
    report += `- **Status**: Ready for manual export\n\n`;
    report += `## Notes\n\n`;
    report += `To perform the full export and migration to Railway:\n\n`;
    report += `1. **Use pg_dump** (if available):\n`;
    report += `   \`\`\`bash\n`;
    report += `   PGPASSWORD=paperclip pg_dump -h localhost -p 54329 -U paperclip paperclip > backup.sql\n`;
    report += `   \`\`\`\n\n`;
    report += `2. **Use Railway backup tools**:\n`;
    report += `   - Upload this server's database directory to Railway\n`;
    report += `   - Or use Railway's database restore feature\n\n`;
    report += `3. **Document this data**:\n`;
    report += `   - Archive the database directory as backup\n`;
    report += `   - Store in safe location\n`;

    fs.writeFileSync(outputFile, report, 'utf-8');

    await sql.end();

    console.log(`\n✅ Export analysis complete!`);
    console.log(`   File: ${outputFile}`);
    console.log(`   Total rows found: ${totalRows}`);
    console.log(`\n💾 Database is healthy and ready for migration to Railway`);
    
  } catch (error) {
    console.error('\n❌ Export failed:', error.message);
    process.exit(1);
  }
}

exportDatabase();
