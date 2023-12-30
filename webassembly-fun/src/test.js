const fs = require('fs');
const source = fs.readFileSync("./math.wasm");
const typedArray = new Uint8Array(source);

WebAssembly.instantiate(typedArray, {
    env: {
        print: (result) => { console.log(`[print] The result is ${result}`); }
    }
}).then(result => {
    const add = result.instance.exports.add;
    const res = add(1, 2);
    console.log(`Result in JS from Zig wasm == ${res}`);
});