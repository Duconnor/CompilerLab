#include <stdlib.h>
#include <string.h>

#include "tree.h"

Node* initNode(char* type, char* value, int linenum) {
	Node *node = (Node*)malloc(sizeof(Node));
	node->parent = node->child = node->sibling = NULL;
	strcpy(node->lexeme.type, type);
	strcpy(node->lexeme.value, value);
	node->lexeme.linenum = linenum;
	return node;
}

void addChild(Node* parent, Node* child) {
	child->parent = parent;
	if (parent->child == NULL)
		parent->child = child;
	else {
		Node* node = parent->child;
		while (node->sibling != NULL) {
			node = node->sibling;
		}
		node->sibling = child;
	}
}

void printTree(Node* root) {
	
}
