export function hello(name) {
  return `Hello, ${name}!`;
}

if (process.env.CI !== 'true') {
  console.log(hello('world'));
}
