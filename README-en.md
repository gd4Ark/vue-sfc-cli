# vue-sfc-cli

[![Build Status](https://travis-ci.com/FEMessage/vue-sfc-cli.svg?branch=master)](https://travis-ci.com/FEMessage/vue-sfc-cli)
[![NPM Download](https://img.shields.io/npm/dm/vue-sfc-cli.svg)](https://www.npmjs.com/package/vue-sfc-cli)
[![NPM Version](https://img.shields.io/npm/v/vue-sfc-cli.svg)](https://www.npmjs.com/package/vue-sfc-cli)
[![NPM License](https://img.shields.io/npm/l/vue-sfc-cli.svg)](https://github.com/FEMessage/vue-sfc-cli/blob/master/LICENSE)
[![Automated Release Notes by gren](https://img.shields.io/badge/%F0%9F%A4%96-release%20notes-00B2EE.svg)](https://github-tools.github.io/github-release-notes/)

vue-sfc-cli exists to provide rich setup to develop a Vue Single File Component (SFC) quickly, writing docs and demo easily, integrated with an automated github workflow, and always ready to publish to npm with best practices.

## Tutorial

### Quick Start

```
npx vue-sfc-cli

# Next there will be a bunch of tips, please be sure to fill out
# Recommend kebab-case style, lowercase letters, multiple words separated by - (dash), such as my-component

# After filling the prompt
cd my-component

# Use git to initialize, so you can use the commit hook
git init

# Install dependency
yarn

# Develop component
yarn dev

# Build
yarn build

# Ready to publish!
# Or use `npm publish`
yarn publish
```

### Options

```
-u, --upgrade
```

According to the template files in the templates directory, new files will be generated and override the files with same name in current component directory. The default override files is defined in update-files.js. This option often used to upgrade the configuration of old components using the latest version of vue-sfc-cli：

```
# cd my-component
npx vue-sfc-cli -u
```

`—files`

If you want to update additional files, you can pass this option, multiple files use `,` to separate

```
npx vue-sfc-cli -u --files package.json,.babelrc.js
```

`—test`

Generate a component template for testing, commonly used in CI .

```
npx vue-sfc-cli --test
```

### Writing Example

The docs directory hosts your component's examples. You just write markdown files, and they will turn into demo. It is also recommended to name the markdown files in kebab-case style.

Take the docs/draggable.md file of [upload-to-ali](https://github.com/FEMessage/upload-to-ali), the upload component as an example.

````
拖拽排序示例

​```vue
<template>
  <upload-to-ali :preview="false" v-model="url" multiple />
</template>
<script>
export default {
  data() {
    return {
      url: [
        'https://picsum.photos/300/300',
        'https://picsum.photos/400/400',
        'https://picsum.photos/555/555'
      ],
    }
  }
}
</script>
​```
````

`yarn dev` can turn this markdown file into live demo, which will show you what the component looks like and it's actual code. You can also modify the code and the demo can hot reload.

![image.png](https://cdn.nlark.com/yuque/0/2019/png/160590/1561702364721-6489a2cd-d21e-4382-b201-f9e6d1b5b022.png?x-oss-process=image/resize,w_1492)

### API Documentation

You can simply write comments in vue file to generate API documentation.

#### Props

Use multiple lines of comments in props

```
props: {
    /**
     * 是否多选
     */
    multiple: {
      type: Boolean,
      default: false
    },
}
```

#### Slot

On the slot line, use the comment at the beginning of @ slot

```
<!--@slot 自定义loading内容，默认类似 element-ui 的 v-loading -->
<slot name="spinner">
  <div class="upload-loading">
    <svg class="circular" viewBox="25 25 50 50">
      <circle class="path" cx="50" cy="50" r="20" fill="none"></circle>
    </svg>
  </div>
</slot>
```

#### Event

Use multi-line comments above the emit event

```
/**
 * 上传过程中
 * @property {string} name - 当前上传的图片名称
 */
this.$emit('loading', name)
```

#### Methods

Above the method to be show in API doc, use multi-line comments and add @public

```
/**
 * 手动触发选择文件事件
 * @public
 */
selectFiles() {
  this.$refs.uploadInput.click()
},
```

preview like this

![image.png](https://cdn.nlark.com/yuque/0/2019/png/160590/1562220787035-7da78cf9-ef5c-49d8-83b1-8cc296aa9add.png?x-oss-process=image/resize,w_1492)

![image.png](https://cdn.nlark.com/yuque/0/2019/png/160590/1562220837322-f67bca09-e910-47e8-aa74-32cde527a4c8.png?x-oss-process=image/resize,w_1492)

### Working with third-party library

To [Element-UI](https://element.eleme.io/) As an example

```
yarn add element-ui
```

Add a file: `styleguide/element.js`

```
import Vue from 'vue'
import Element from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
 Vue.use(Element)
```

Modify configuration files: `styleguide.config.js`

```
module.exports = {
  // ...
  require: [
    './styleguide/element.js'
  ]
}
```

### Environment variable

If you need to use environment variables, it is recommended to use `dotenv`

```
yarn add dotenv --dev
```

```
// styleguide.config.js
const webpack = require('webpack')
const dotenv = require('dotenv')

module.exports = {
  webpackConfig: {
    // ...
    plugins: [
      new webpack.DefinePlugin({
        'process.env': JSON.stringify(dotenv.config().parsed)
      })
    ]
  }
}
```

### Prettier and husky

The component template has a built-in prettier and husky setup that can format code when you commit.

However, you need to execute the git init command before running yarn ,otherwise the commit hook will not take effect.

### Notice

It is not recommended to generate components under Windows, as `.sh` files may lost execution permissions.

## requirement

Node.js 8.x
