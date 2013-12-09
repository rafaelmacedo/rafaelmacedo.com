module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json"),
    concat: {
      js: {
        src: [ 
          "assets/javascripts/jquery.js",
          "assets/javascripts/jquery.timeago.js",
          "assets/javascripts/prefixfree.js"
        ],
        dest: "public/javascripts/application.js"
      }
    },
    cssmin: {
      css: {
        src: "public/stylesheets/application.css",
        dest: "public/stylesheets/application.css"
      }
    },
    sass: {
      dist: {
        options: {
          bundleExec: true
        },
        files: {
          "public/stylesheets/application.css": "assets/stylesheets/application.scss"
        }
      }
    },
    uglify : {
      js: {
        files: {
          "public/javascripts/application.js" : [
            "public/javascripts/application.js"
          ]
        }
      }
    },
    watch: {
      files: ["assets/stylesheets/*", "assets/javascripts/*"],
      tasks: ["sass", "cssmin", "uglify"]
    }
  });

  grunt.loadNpmTasks("grunt-contrib-concat");
  grunt.loadNpmTasks("grunt-contrib-cssmin");
  grunt.loadNpmTasks("grunt-contrib-sass");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.loadNpmTasks("grunt-contrib-watch");  
  grunt.registerTask("default", [ "sass", "cssmin:css", "concat:js", "uglify:js" ]);
};
