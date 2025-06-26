import typescript from 'rollup-plugin-typescript2';

export default {
  input: 'app.ts',
  entry: {
    lambda: './lambda.ts',
  },
  output: {
    file: 'dist/app.js',
    format: 'cjs'
  },
  plugins: [typescript()],
  external: ['aws-lambda', '@nestjs/common', '@nestjs/core']
}; 