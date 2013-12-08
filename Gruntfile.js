module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON("package.json"),
    concat: {
      css: { 
        src: [ "assets/stylesheets/*" ],
        dest: "public/stylesheets/application.css"
      },
      js: {
        src: [ "assets/javascripts/*" ],
        dest: "public/javascripts/application.js"
      }
    },
    cssmin: {
      css: {
        src: "public/stylesheets/application.css",
        dest: "public/stylesheets/application.css"
      }
    },
    uglify : {
      js: {
        files: {
          "application" : [ "public/javascripts/application.js" ]
        }
      }
    },
    watch: {
      files: ["assets/stylesheets/*", "assets/javascripts/*"],
      tasks: ["concat", "cssmin", "uglify"]
    }
  });

  grunt.loadNpmTasks("grunt-contrib-concat");
  grunt.loadNpmTasks("grunt-contrib-uglify");
  grunt.loadNpmTasks("grunt-contrib-watch");
  grunt.loadNpmTasks("grunt-contrib-cssmin");
  grunt.registerTask("default", [ "concat:css", "cssmin:css", "concat:js", "uglify:js" ]);
};
