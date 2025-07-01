import typescript from 'rollup-plugin-typescript2';

// Layer中的依赖，构建时排除
const layerDependencies = [
  '@nestjs/common',
  '@nestjs/core', 
  '@nestjs/platform-express',
  '@nestjs/config',
  '@nestjs/axios',
  '@prisma/client',
  'axios',
  'rxjs',
  'dotenv',
  'serverless-http'
];

export default {
  input: 'lambda.ts',
  output: {
    file: 'dist/lambda.js',
    format: 'cjs'
  },
  plugins: [
    typescript({
      check: false
    })
  ],
  external: [
    'aws-lambda',
    ...layerDependencies,
    // 其他Node.js内置模块
    'fs', 'path', 'crypto', 'http', 'https', 'url'
  ]
}; 