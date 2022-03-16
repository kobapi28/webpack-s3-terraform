import { readFileSync } from 'fs';
import { setOutput, setFailed, getInput } from '@actions/core';

const generateTable = (obj) => {
  if (obj === []) return;
  console.log('|auditProperty|actual|expected|level|')
  console.log('|---|---|---|---|')
  for (const o of obj) {
    console.log(`|${o['auditProperty']}|${o['actual']}|${o['expected']}|${o['level']}|`)
  }
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


