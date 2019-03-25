#include <stdlib.h>
#include <stdio.h>
#include <string.h>

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

static void printTreeRec(Node *root, int height) {
	if (root == NULL)
		return;
	for (int i = 0; i < height; i++)
		printf("  ");
	printf("%s", root->lexeme.type);
	if (strcmp(root->lexeme.value, " ") != 0) {
		printf(": %s\n", root->lexeme.value);
	} else {
		printf(" (%d)\n", root->lexeme.linenum);
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
