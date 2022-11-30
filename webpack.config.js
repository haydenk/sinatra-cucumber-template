const path = require("path");
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const { ESBuildMinifyPlugin } = require('esbuild-loader');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const production = process.env.NODE_ENV === 'production';

const config = {
    mode: production ? 'production' : 'development',
    stats: production ? 'normal' : 'minimal',
    entry: {
        app: './app/javascript/application.js'
    },
    output: {
        path: path.resolve('dist'),
        filename: 'js/[name].js',
        chunkFilename: 'js/[name].[chunkhash:9].js'
    },
    devtool: 'inline-source-map',
    devServer: {
        static: {
            directory: path.resolve(__dirname, 'public/'),
        },
        // publicPath: '/assets/',
        // hot: true,
        proxy: {
            "/**": {
                target: 'http://127.0.0.1:4567',
                headers: { Connection: 'keep-alive' },
                logLevel: 'debug'
            }
        }
    },
    watchOptions: {
        ignored: /node_modules/,
    },
    plugins: [
        new CleanWebpackPlugin(),
        new MiniCssExtractPlugin({
            filename: 'css/[name].[chunkhash:9].css'
        }),
    ],
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'esbuild-loader'
            },
            {
                test: /\.css$/i,
                exclude: /node_modules/,
                use: ['style-loader', 'css-loader', 'postcss-loader']
            },
            { // If you need to parse images
                test: /\.(png|svg|jpg|gif)$/,
                use: [
                    'file-loader'
                ]
            },
            { // If you need local fonts
                test: /\.(woff|woff2|eot|ttf|otf)$/,
                use: ['file-loader']
            }
        ]
    }
};

if (production) {
    config.optimization = {
        minimize: true,
        minimizer: [
            new ESBuildMinifyPlugin({
                css: true
            })
        ]
    }

}

module.exports = config;