module.exports = {
  ci: {
    collect: {
      staticDistDir: './public/'
    },
    upload: {
      target: 'temporary-public-storage',
    },
    assert: {
      assertions: {
        "categories:performance": ["error", { "minScore": 90 }],
        "categories:accessibility": ["error", { "minScore": 90 }],
        "categories:best-practices": ["error", { "minScore": 90 }],
        "categories:seo": ["error", { "minScore": 90 }]
      }
    }
  },
};