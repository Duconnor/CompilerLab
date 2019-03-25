/*
 * Data structure of grammar tree
 * Use parent-child(left most child)-sibling mode to represent the tree
*/
#ifndef TREE_H
#define TREE_H

#define CAPACITY 32


typedef struct LexemeInNode {
	char type[CAPACITY];
	char value[CAPACITY];
	int linenum;
} Lexeme;

typedef struct GrammarTreeNode {
	//struct GrammarTreeNode *parent; /* Pointer pointing to the parent node of this node */
	struct GrammarTreeNode *child; /* Pointer pointing to the first child of this node */
	struct GrammarTreeNode *sibling; /* Pointer pointing to the sibling of this node */
	Lexeme lexeme;
} Node;

Node* initNode(char *type, char *value, int linenum);

void addChild(Node *parent, Node *child);

void printTree(Node *root);

void destroyTree(Node *root);

#endif
