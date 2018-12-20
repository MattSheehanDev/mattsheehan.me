## Setup ##

Install node packages
```sh
# npm
npm install
# or yarn
yarn install
```

Install gems
```sh
bundle install
```

Build and serve the site
```sh
# build the site
bundle exec jekyll build
# build and serve the site with jekyll's development webserver
bundle exec jekyll serve
```

## Setting up mattsheehan.me ##

###### Install LESS ######
```
$> sudo npm install -g less
```
Note: the path to `lessc` cmd should be `/usr/local/bin/lessc` <br/>
Yout might have to specify `nodejs <lessc path> <input files>`

#### Ruby ####

###### Install Ruby ######
Refer to [ruby installation](https://github.com/sheehamj13/mint-17-3-help/blob/master/ruby/ruby-installation.md)

###### Install Jekyll ######
```
$> gem install jekyll
```

###### Install jekyll-paginate ######
```
$> gem install jekyll-paginate
```


## Building mattsheehan.me ##
To serve the webpage use jekyll's `serve` command
```
$> jekyll serve
```
To only build the webpage use jekyll's `build` command
```
$> jekyll build
```
