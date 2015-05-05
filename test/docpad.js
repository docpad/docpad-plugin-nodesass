module.exports = {
  plugins: {
    nodesass: {
      neat: true,
      options: {
        imagePath: '/path/to/images',
        outputStyle: 'compressed',
        precision: 3,
        includePaths: [__dirname + "/src/documents/includePath"]
      }
    }
  }
};
