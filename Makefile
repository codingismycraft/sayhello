################################################################################
#
# Make file to build an executable assuming include - src - debug - release 
# directory structure.
#
################################################################################
CPP=g++ -std=c++17
INCLUDE=-Iinclude

SRC=$(wildcard src/*.cpp)

APPNAME=sayhello

DEBUG_OBJ=$(subst src, debug, $(SRC:.cpp=.o))
DEBUG_EXE=debug/${APPNAME}

debug/%.o: src/%.cpp
	${CPP} -g -Wall -MMD -MP  ${INCLUDE} -c $< -o $@

debug: $(DEBUG_OBJ)
	${CPP}  -Wall -o $(DEBUG_EXE) ${DEBUG_OBJ}


RELEASE_OBJ=$(subst src, release, $(SRC:.cpp=.o))
RELEASE_EXE=release/${APPNAME}

release/%.o: src/%.cpp
	${CPP} -O -MMD -MP ${INCLUDE} -c $< -o $@

release: $(RELEASE_OBJ)
	${CPP} -Wall -o $(RELEASE_EXE) ${RELEASE_OBJ}

clean:
	rm debug/* release/*

-include debug/*.d
-include release/*.d