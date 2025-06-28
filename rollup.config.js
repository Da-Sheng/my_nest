import typescript from 'rollup-plugin-typescript2';

export default {
  input: 'main.ts',
  entry: {
    lambda: './lambda.ts',
  },
  output: {
    file: 'dist/main.js',
    format: 'cjs'
  },
  plugins: [typescript()],
  external: ['aws-lambda', '@nestjs/common', '@nestjs/core']
}; 