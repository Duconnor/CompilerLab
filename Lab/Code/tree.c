#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "tree.h"

Node* initNode(char *type, char *value, int linenum) {
	Node *node = (Node*)malloc(sizeof(Node));
	//node->parent = node->child = node->sibling = NULL;
	if (type != NULL) {
		strcpy(node->lexeme.type, type);
	} else {
		printf("Error in initNode. Invalid NULL argument\n");
	}
	if (value != NULL) {
		strcpy(node->lexeme.value, value);
	} else {
		strcpy(node->lexeme.value, " ");
	}
	node->lexeme.linenum = linenum;
	return node;
}

void addChild(Node *parent, Node *child) {
	//child->parent = parent;
	if (parent->child == NULL)
		parent->child = child;
	else {
		Node *node = parent->child;
		while (node->sibling != NULL) {
			node = node->sibling;
		}
		node->sibling = child;
	}
}

static int isEpsilonProduction(Node *root) {
	char *type = root->lexeme.type;
	return root->child == NULL && (strcmp(type, "ExtDefList") == 0 || strcmp(type, "OptTag") == 0 || strcmp(type, "StmtList") == 0 || strcmp(type, "DefList") == 0);
}

static void printTreeRec(Node *root, int height) {
	if (root == NULL || isEpsilonProduction(root))
		return;
	for (int i = 0; i < height; i++)
		printf("  ");
	printf("%s", root->lexeme.type);
	if (strcmp(root->lexeme.value, " ") != 0) {
		printf(": %s\n", root->lexeme.value);
	} else {
		int isTerminal = 1;
		for (int i = 0; i < strlen(root->lexeme.type); i++)
			if (!isupper(root->lexeme.type[i])) {
				printf(" (%d)\n", root->lexeme.linenum);
				isTerminal = 0;
				break;
			}
		if (isTerminal)
			printf("\n");
	}
	Node *node = root->child;
	while (node != NULL) {
		printTreeRec(node, height + 1);
		node = node->sibling;
	}
}

void printTree(Node *root) {
	printTreeRec(root, 0);
}

void destroyTree(Node *root) {
	if(root == NULL)
		return;
	Node *node = root->child;
	while (node != NULL) {
		Node *temp = node;
		node = node->sibling;
		destroyTree(temp);
	}
	free(root);
}

/*
int main() {
	int num = 0;
	Node *root = initNode("S", NULL, num++);
	addChild(root, initNode("S", NULL, num));
	addChild(root, initNode("S", NULL, num));
	addChild(root, initNode("L", "*", num++));
	Node *node = root->child;
	addChild(node, initNode("S", NULL, num));
	addChild(node, initNode("S", NULL, num));
	addChild(node, initNode("L", "+", num));
	Node *sib = node->sibling;
	addChild(sib, initNode("L", "a", num++));
	node = node->child;
	addChild(node, initNode("L", "a", num));
	addChild(node->sibling, initNode("L", "a", num));
	printTree(root);
	destroyTree(root);
}
*/
