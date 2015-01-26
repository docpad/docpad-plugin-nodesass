module.exports = {
  plugins: {
    nodesass: {
      imagePath: '/path/to/images',
      neat: true,
      outputStyle: 'compressed',
      precision: 3,
      includePaths: [__dirname + "/src/documents/includePath"]
    }
  }
};
