module.exports = {
    mode: "development",
    entry: './src/app.coffee',
    output: {
        filename: 'bundle.js',
        path: __dirname
    },
    module: {
        rules: [
            {
                test: /\.coffee?$/,
                loader: 'coffee-loader',
                exclude: /node_modules/,
            },
        ]
    },
    resolve: {
        extensions: [".coffee", ".js"]
    },
};