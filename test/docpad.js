module.exports = {
  plugins: {
    nodesass: {
      neat: true,
      options: {
        outputStyle: 'compressed',
        precision: 3,
        includePaths: [__dirname + "/src/documents/includePath"]
      }
    }
  }
};
