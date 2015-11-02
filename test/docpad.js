module.exports = {
  plugins: {
    nodesass: {
      options: {
        outputStyle: 'compressed',
        precision: 3,
        includePaths: [__dirname + "/src/documents/includePath"]
      }
    }
  }
};
