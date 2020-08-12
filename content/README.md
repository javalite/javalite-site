# Content for the [JavaLite](http://javalite.io) site.


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


## How to refresh content 

The article will refresh automatically in dev env. 
However, the properties files and breadcrumbs will not. 
In order for  properties files to be picked up, 
do `mvn clean install` under module `content`. 


    

 
    
    