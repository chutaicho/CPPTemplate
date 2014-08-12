#
# Created by Takashi Aoki 
#

TARGET = $(shell basename `pwd`)
CC = g++
CFLAGS = -MMD -MP
INCLUDE = -I./src

ODIR = obj
SDIR = src
DEPS = $(wildcard src/*.h)
SRCS = $(wildcard src/*.cpp)

OBJS = $(addprefix $(ODIR)/, $(SRCS:.cpp=.o))
DEPENDS = $(OBJS:.o=.d)

# Inspired by http://urin.github.io/posts/2013/simple-makefile-for-clang/
$(ODIR)/%.o: %.cpp $(DEPS)
	@[ -d $(ODIR)/$(SDIR) ] || mkdir -p $(ODIR)/$(SDIR)
	$(CC) $(CFLAGS) $(INCLUDE) -c -o $@ $<

$(TARGET): $(OBJS)
	$(CC) -o $@ $^
	@make message

all: clean $(TARGET)

run:
	@./$(TARGET)

clean:	
	rm -f $(ODIR)/$(SDIR)/* $(TARGET)
	rmdir $(ODIR)/$(SDIR) $(ODIR)

message:
	@echo
	@echo "     compiling done"
	@echo "     to launch the application"
	@echo
	@echo "     ./$(TARGET)"
	@echo "     "
	@echo "     - or -"
	@echo "     "
	@echo "     $(MAKE) run"
	@echo

help:
	@echo
	@echo "     make:		make Release"
	@echo "     make run:		launch the application"
	@echo "     make all:		clean and make Release"
	@echo "     make clean:	clean everything"
	@echo "     make help:		this help message"
	@echo

-include $(DEPENDS)