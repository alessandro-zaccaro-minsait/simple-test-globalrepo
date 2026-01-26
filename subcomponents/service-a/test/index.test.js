import { hello } from '../src/index.js';

const assert = (cond, msg) => { if (!cond) { throw new Error(msg); } };

assert(hello('Jenkins') === 'Hello, Jenkins!', 'hello() should greet correctly');
console.log('All tests passed.');
