igkiou's C++ Style Guide
============

This guide documents the style conventions used in C/C++ repositories by [@igkiou](https://github.com/igkiou). *Style* in this case refers to both source file formatting and coding and design practices.

The adopted style conventions are strongly influenced by the [Google C++ Style Guide](http://google-styleguide.googlecode.com/svn/trunk/cppguide.html) and the styling conventions of the [Mitsuba Physically-Based Renderer](http://www.mitsuba-renderer.org). With respect to the Google C++ Style Guide in particular, it is by default assumed that it applies, unless explicitly contradicted by a convention described below. For this reason, the emphasis of this (evolving) guide is on differences the Google C++ Style Guide. In addition to describing the adopted conventions, some effort has been put into also explaining the rationale behind their use.

To help enforce these conventions, the guide is accompanied by an Eclipse CDT-importable template that partially implements it. Furthermore, given the large overlap with the Google C++ Style Guide, [cpplint](http://google-styleguide.googlecode.com/svn/trunk/cpplint/) can be used to identify violations of this guide's conventions. Due to differences with the Google C++ Style Guide, it is recommended that `cpplint` be called with the following arguments,

```shell
./cpplint.py –filter=-whitespace/tab,-whitespace/labels
```

General practices
-----------------

### Enumerations

Enumeration types have a second to last *length entry* that is set equal to the number of valid entries (without the length entry), and a last *invalid entry* that is set equal to `-1`.

### Scoped enumerations

Only scoped enums are used. The practice of using length and invalid entries (see previous) results in name collisions when unscoped enum are used.

### Boost

Boost libraries should be used whenever this helps save time or write more compact code.

### Detail namespaces

When it is necessary to indicate that some names should not be used outside a header file, the corresponding definitions or declarations are placed inside a `detail` namespace. In most cases, they are instead placed in an implementation file inside an unnamed namespace, but a `detail` namespace may be necessary in some cases (e.g., in header-only implementations). Unnamed namespaces are not used in header files.

### Default and empty destructors

When it is necessary to provide a destructor, a destructor defaulted using `= default` is preferred to an empty destructor.

### Rule priority

TODO.

Formatting
----------

### Indentation

Indentation is done using tabs, which expand to *four* spaces. One "indent" is one tab.

### Block scopes

When it is necessary to wrap a line starting a new block scope (e.g., a `for` statement), any subsequent lines have at least two additional indents relative to the first line. This is to distinguish them from the code block that will follow, which has only one additional indent.

### Parameter and argument lists

When it is necessary to wrap a function's parameters or arguments, they are wrapped at the maximum number of indents that is no more that one character to the right of the first character of the parameter or argument list. If this is impractical, they are wrapped at two additional indents.

### Initializer lists

When it is necessary to wrap initializer lists, they are formatted the same as parameter and argument lists. The colon `:` starting the initializer list should be in the same line as the end of the constructor parameter name.

### Pointer and reference declarations

The asterisk and ampersand are placed adjacent to the type.

### Class format

The `public`, `protected`, and `private` keywords are at the same indentation level as the `class` keyword.

Naming conventions
------------------

### File names

Header files end in `.h`, and C/C++ implementation files in `.cpp`.

### Name format

Names are always written in camel-case, sometimes with the addition of a prefix consisting of lower-case characters followed by an underscore, and with the exception for macros. These are described in detail below.

### Classes and structures

Classes and structures use camel-case starting with an upper-case letter.

### Type names

Type names use camel-case starting with an upper-case letter.

### Variables

Variables use camel-case starting with a lower-case letter.

### Functions

Functions use camel-case starting with a lower-case letter.

### Macros

Macros (which should be used scarcely) use upper-case letters with underscores separating words.

### Enumerations

Enumeration types and entries start with an upper-case **E** (`E-type`). The length entry has the name `ELength`, and the invalid entry has the name `EInvalid`. Variables that are of a type of an enumeration start with **e** (`e-type`). This is to enhance recognizability of these types and variables.

### Bools

Functions returning `bool` and variables of type `bool` start with `is` (`b-type`). This is to enhance recognizability of these variables and functions.

### Constants

Compile-time constants start with **k** (`k-type`). This is to enhance recognizability of these variables.

### Pointers

Type names that are defined as pointers to some other type start with an upper-case **P** (`P-type`). Variables that are of type pointer to some type start with **p** (`p-type`). This is to enhance recognizability of these types and variables. Note that a variable that is of a `P-type`type is not a `p-type`variable.

### Attributes

Attributes of classes and structs have the prefix `m_`. This is to enhance recognizability, but also to facilitate maintenance, by making exploring the attributes of a class straightforward (e.g., type `m_`, and auto-complete).

### Accessors and mutators

Accessor ("getter") and mutator ("setter") member functions of a class are named by concatenating the prefix `get_` and `set_`, respectively, and the part of the name of the attribute they provide access to after its `m_` prefix. This is to enhance recognizability, but also to facilitate maintenance, by making exploring functions that provide access to attributes of a class straightforward (e.g., type `get_` or `set_`, and auto-complete). In mutators, the parameter is named after the attribute it is assigned to, without the `m_` prefix.

### Constructors

In copy and move constructors, the parameter is named `other`. This is to make facilitate reuse of standard forms of these constuctors (e.g., copy-and-swap idiom) and refactoring. In other constructors, function parameters are named after the attributes they are assigned to, without the `m_` prefix.

### Cope and move operators

In copy and move operators, the parameter is named `other`.

### Swap and clone functions

When extending `swap`, the two parameters are named `first` and `second`. Functions with functionality analogous to `swap` have similarly named parameters. When defining functions with cloning or copying functionality (e.g., private implementations of copy constructors), the parameter that is cloned is named `other`.

### Static and const

When a variable is declared both `static` and `const`, the `static` keyword is the leftmost one.

Example
-------

Below is an example demonstrating many of the above conventions.

```cpp
// Bad practice, used only for demonstration of macro naming convention.
#define NUM_DAYS_OF_YEAR 360

enum class EMonth {
	EJanuary = 0,
	EFebrurary,
	/* ... */
	EDecember,
	ELength,
	EInvalid = -1
};

static const int kNumOfDays = 30;

struct Date {
public:
	int m_day;
	EMonth m_eMonth;
	int m_year;
};

bool isValidDate(const Date& query);

typedef Date* PDate;

class LogEntry {
public:
	LogEntry(const PDate& entryDate, double* pEntryData, 
			const std::string& entryText) :
			m_entryDate(entryDate),
			m_pEntryData(pEntryData),
			m_entryText(entryText) {}

	LogEntry(const LogEntry& other);

	LogEntry& operator=(const LogEntry& other);

	inline const PDate& get_entryDate() const {
		return m_entryDate;
	}

	inline const double* get_pEntryData() const {
		return m_pEntryData;
	}

	inline void set_entryDate(const PDate& entryDate) {
		m_entryDate = entryDate;
	}

	inline void set_pEntryData(double* pEntryData) {
		m_pEntryData = pEntryData;
	}

	void printLogEntry() const;

private:
	PDate m_entryDate;
	double* m_pEntryData;
	std::string m_entryText;
};
```
