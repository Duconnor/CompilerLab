# GNU make手册：http://www.gnu.org/software/make/manual/make.html
# ************ 遇到不明白的地方请google以及阅读手册 *************

# 编译器设定和编译选项
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -std=c99

# 编译目标：src目录下的所有.c文件
CFILES = $(shell find ./ -name "*.c")
OBJS = $(CFILES:.c=.o)
LFILE = $(shell find ./ -name "*.l")
YFILE = $(shell find ./ -name "*.y")
LFC = $(shell find ./ -name "*.l" | sed s/[^/]*\\.l/lex.yy.c/)
YFC = $(shell find ./ -name "*.y" | sed s/[^/]*\\.y/syntax.tab.c/)
LFO = $(LFC:.c=.o)
YFO = $(YFC:.c=.o)

parser: syntax $(filter-out $(LFO),$(OBJS))
	$(CC) -o parser $(filter-out $(LFO),$(OBJS)) -lfl -ly

syntax: lexical syntax-c
	$(CC) -c $(YFC) -o $(YFO)

lexical: $(LFILE)
	$(FLEX) -o $(LFC) $(LFILE)

syntax-c: $(YFILE)
	$(BISON) -o $(YFC) -d -v $(YFILE)

-include $(patsubst %.o, %.d, $(OBJS))

# 定义的一些伪目标
.PHONY: clean test
test:
	./parser ../Test/A_1.cmm ../Out/A-1.s ../Out2/A-1.ir
	./parser ../Test/A_2.cmm ../Out/A-2.s ../Out2/A-2.ir
	./parser ../Test/A_3.cmm ../Out/A-3.s ../Out2/A-3.ir
	./parser ../Test/A_4.cmm ../Out/A-4.s ../Out2/A-4.ir
	./parser ../Test/A_5.cmm ../Out/A-5.s ../Out2/A-5.ir
	./parser ../Test/B_1.cmm ../Out/B-1.s ../Out2/B-1.ir
	./parser ../Test/B_2.cmm ../Out/B-2.s ../Out2/B-2.ir
	./parser ../Test/B_3.cmm ../Out/B-3.s ../Out2/B-3.ir
	./parser ../Test/C_1.cmm ../Out/C-1.s ../Out2/C-1.ir
	./parser ../Test/C_2.cmm ../Out/C-2.s ../Out2/C-2.ir
clean:
	rm -f parser lex.yy.c syntax.tab.c syntax.tab.h syntax.output
	rm -f $(OBJS) $(OBJS:.o=.d)
	rm -f $(LFC) $(YFC) $(YFC:.c=.h)
	rm -f *~
