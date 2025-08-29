module.exports = function(api) {
  const isTestEnv = api.env('test')
  const isDevelopmentEnv = api.env('development')
  const isProductionEnv = api.env('production')

  return {
    presets: [
      [
        '@babel/preset-env',
        {
          targets: isTestEnv ? { node: 'current' } : '> 0.25%, not dead',
          modules: isTestEnv ? 'commonjs' : false,
          useBuiltIns: 'entry',
          corejs: 3
        }
      ],
      [
        '@babel/preset-react',
        {
          development: isDevelopmentEnv || isTestEnv
        }
      ]
    ],
    plugins: [
      'babel-plugin-macros',
      '@babel/plugin-syntax-dynamic-import',
      [
        '@babel/plugin-proposal-class-properties',
        { loose: true }
      ],
      [
        '@babel/plugin-transform-runtime',
        { helpers: false, regenerator: true, corejs: false }
      ]
    ].filter(Boolean)
  }
}
