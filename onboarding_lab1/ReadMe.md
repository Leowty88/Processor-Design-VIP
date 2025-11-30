1. target_sources are relative to the CMakeLists.txt file not to the build directory 

2. cmake configures the project and generates the build files 
the build tool (ninja or --build .) actually compiles the program 

3. keep the source tree clean 
avoid mixing real code with temp files