/*
 * Data structure of grammar tree
 * Use parent-child(left most child)-sibling mode to represent the tree
*/

typedef struct GrammarTreeNode {
	Node* parent; /* Pointer pointing to the parent node of this node */
	Node* child; /* Pointer pointing to the first child of this node */
	Node* sibling; /* Pointer pointing to the sibling of this node */
	
} Node;
