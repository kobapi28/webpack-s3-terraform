import { createWriteStream, readFileSync } from 'fs';
import { setOutput, setFailed, getInput } from '@actions/core';

const generateTable = (obj) => {
  if (obj === []) return;
  const stream = createWriteStream('result-markdown.md');
  stream.write('|auditProperty|actual|expected|level|\n');
  stream.write('|---|---|---|---|\n')
  for (const o of obj) {
    stream.write(`|${o['auditProperty']}|${o['actual']}|${o['expected']}|${o['level']}|\n`)
  }
  stream.end('\n')
}


try {
  const filePath = getInput('json-file-path')
  const file = readFileSync(filePath);
  generateTable(JSON.parse(file.toString()));
  setOutput('success!');
} catch (err) {
  console.log(err);
  setFailed(err);
}


