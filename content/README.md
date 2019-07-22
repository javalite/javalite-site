# Content for the [JavaLite](http://javalite.io) site.


## Environment variable

Set the environment variable similar to this:
 
    export JAVALITE_SITE_PROJECT=/home/igor/projects/javalite/javalite-site

## Pandoc required

Install pandoc :

~~~~
sudo apt-get install pandoc
~~~~

## How to build 

~~~~
./build.sh
~~~~

## Where is the output? 

The output is located: 

    ./target/output/blog
    
## How to write a new article

* execute a script to generate files:

     ./scripts/new_blog.sh name-of-new-article

* Start editing files


## How to push to prod

    ./scripts/publish_aws.ah
    
After that, need to reload the blog: http://javalite.io/blog/reload


    

 
    
    