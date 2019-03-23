/*
 * Data structure of grammar tree
 * Use parent-child(left most child)-sibling mode to represent the tree
*/

#define CAPACITY 32

typedef struct LexemeInNode {
	char type[CAPACITY];
	char value[CAPACITY];
	int linenum;
} Lexeme;

typedef struct GrammarTreeNode {
	Node* parent; /* Pointer pointing to the parent node of this node */
	Node* child; /* Pointer pointing to the first child of this node */
	Node* sibling; /* Pointer pointing to the sibling of this node */
	Lexeme lexeme;
} Node;

Node* initNode(char* type, char* value, int linenum);

void addChild(Node* parent, Node* child);

void printTree(Node* root);
