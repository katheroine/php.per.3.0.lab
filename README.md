# PHP.PER.3.0.lab

Laboratory of PER Coding Style 3.0.

> This repository is a standalone part of a larger project: **[PHP.lab](https://github.com/katheroine/php.lab)** — a curated knowledge base and laboratory for PHP engineering.

**Usage**

To run the example application with *Docker* use command:

```console
docker compose up -d
```

After creating the *Docker container* the *Composer dependencies* have to be defined and installed:

```console
docker compose exec application composer require --dev squizlabs/php_codesniffer \
&& docker compose exec application composer install
```

Tom make *PHP Code Sniffer commands* easily accessible run:

```console
docker compose exec application ln -s /var/www/vendor/bin/phpcs /usr/local/bin/phpcs \
&& docker compose exec application ln -s /var/www/vendor/bin/phpcbf /usr/local/bin/phpcbf
```

To run *PHP Code Sniffer* use command:

```console
docker compose exec application /var/www/vendor/bin/phpcs
```

or, if the shortcut has been created:

```console
docker compose exec application phpcs
```

To update `Composer dependencies` use command (should be done before the command below):

```console
docker compose exec application composer update
```

To login into the *Docker container* use command:

```console
docker exec -it per-cs-30-example-app /bin/bash
```

**License**

This project is licensed under the GPL-3.0 - see [LICENSE](LICENSE).

**Official documentation**

[PHP-FIG PER Coding Style Official documentation](https://www.php-fig.org/per/coding-style/)

**What are PSRs**

**PER** stands for [*PHP Evolving Recommendation*](https://www.php-fig.org/per).

## Overview

This specification extends, expands and replaces **PSR-12**, the extended coding style guide and requires adherence to **PSR-1**, the basic coding standard.

Like **PSR-12**, the intent of this specification is to *reduce cognitive friction when scanning code from different authors*. It does so by enumerating a shared set of rules and expectations about how to format PHP code. This *PSR* seeks to provide a set that coding style tools can implement, projects can declare adherence to and developers can easily relate to between different projects. When various authors collaborate across multiple projects, it helps to have one set of guidelines to be used among all those projects. Thus, the benefit of this guide is not in the rules themselves but the sharing of those rules.

*PSR-12* was accepted in 2019 and since then a number of changes have been made to PHP which have implications for coding style guidelines. Whilst *PSR-12* is very comprehensive of PHP functionality that existed at the time of writing, new functionality is very open to interpretation. This *PER*, therefore, seeks to clarify the content of *PSR-12* in a more modern context with new functionality available, make the errata to *PSR-12* binding and further update it according to new data and language changes.

### Previous language versions

Throughout this document, any instructions MAY be ignored if they do not exist in versions of PHP supported by your project.

**Example**

This example encompasses some rules below as a quick overview:

```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\{ClassA as A, ClassB, ClassC as C};
use Vendor\Package\SomeNamespace\ClassD as D;

use function Vendor\Package\{functionA, functionB, functionC};

use const Vendor\Package\{ConstantA, ConstantB, ConstantC};

class Foo extends Bar implements FooInterface
{
    public function sampleFunction(int $a, int $b = null): array
    {
        if ($a === $b) {
            bar();
        } elseif ($a > $b) {
            $foo->bar($arg1);
        } else {
            BazClass::bar($arg2, $arg3);
        }
    }

    final public static function bar()
    {
        // ...
    }
}

enum Beep: int
{
    case Foo = 1;
    case Bar = 2;

    public function isOdd(): bool
    {
        return $this->value() % 2;
    }
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#overview)

## General

**Code MUST follow all rules outlined in [PSR-1](https://www.php-fig.org/psr/psr-1/).**
[🔗](https://www.php-fig.org/per/coding-style/#21-basic-coding-standard)

**The term `StudlyCaps` in [PSR-1](https://www.php-fig.org/psr/psr-1/) MUST be interpreted as `PascalCase` where the first letter of each word is capitalized including the very first letter.**
[🔗](https://www.php-fig.org/per/coding-style/#21-basic-coding-standard)

## Files

##### ✤ File ending character

**All PHP files MUST use the `Unix LF (linefeed)` line ending only.**
[🔗](https://www.php-fig.org/per/coding-style/#22-files)

A [newline](https://en.wikipedia.org/wiki/Newline) (frequently called **line ending**, **end of line (`EOL`)**, **next line (`NEL`)** or **line break**) is a control character or sequence of control characters in character encoding specifications such as `ASCII`, `EBCDIC`, `Unicode`, etc. This character, or a sequence of characters, is used to *signify the end of a line of text and the start of a new one*.

The Unicode standard defines a number of characters that conforming applications should recognize as line terminators:

* `LF` - Line Feed, U+000A
* `VT` - Vertical Tab, U+000B
* `FF` - Form Feed, U+000C
* `CR` - Carriage Return, U+000D
* `CR+LF` - CR (U+000D) followed by LF (U+000A)
* `NEL` - Next Line, U+0085
* `LS` - Line Separator, U+2028
* `PS` - Paragraph Separator, U+2029

**`LF`** is recognized by *POSIX* standard oriented systems: `Unix` and Unix-like systems (`Linux`, `macOS`, `*BSD`, `AIX`, `Xenix`, etc.), `QNX 4+`, `Multics`, `BeOS`, `Amiga`, `RISC OS`, and others.

**`CR+LF`** is recognized by `Windows`, `MS-DOS` compatibles, `Atari TOS`, `DEC TOPS-10`, `RT-11`, `CP/M`, `MP/M`, `OS/2`, `Symbian OS`, `Palm OS`, `Amstrad CPC`, and most other early non-Unix and non-IBM operating systems

The *line ending character* can be set in the code editor or IDE settings (usually it is `LF` by default).

##### ✤ File ending line

**All PHP files MUST end with a non-blank line, terminated with a single `LF`.**
[🔗](https://www.php-fig.org/per/coding-style/#22-files)

**`index.php`**

```php
<?php

require_once(__DIR__ . '/../vendor/autoload.php');
require_once('structure.php');
require_once('view.php');

```

##### ✤ Omitting of the ending PHP tag `?>`

**The closing `?>` tag MUST be omitted from files containing only PHP.**
[🔗](https://www.php-fig.org/per/coding-style/#22-files)

**`HtmlDocAuthor.php`**

```php
<?php

declare(strict_types=1);

namespace PHPLab\StandardPERCS;

class HtmlDocAuthor
{
    public const EMAIL_DOMAIN = 'php.lab';

    public $name = 'Some Author';
    public $email = 'author@' . self::EMAIL_DOMAIN;
}

```

### Lines

##### ✤ Line length hard limit

**There MUST NOT be a hard limit on line length.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

##### ✤ Line lenght soft limit

**The soft limit on line length MUST be `120` characters.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

##### ✤ Line length recomended limit

**Lines SHOULD NOT be longer than `80` characters.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

**Lines longer than that SHOULD be split into multiple subsequent lines of no more than `80` characters each.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

##### ✤ Trailing whitespaces at the end of lines

**There MUST NOT be trailing whitespace at the end of lines**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

##### ✤ Blank lines for redability

**Blank lines MAY be added to improve readability and to indicate related blocks of code except where explicitly forbidden.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

**`HtmlDocAuthor.php`**

```php

declare(strict_types=1);

namespace PHPLab\StandardPERCS;

class HtmlDocAuthor
{
    public const EMAIL_DOMAIN = 'php.lab';

    public $name = 'Some Author';
    public $email = 'author@' . self::EMAIL_DOMAIN;
}

```

##### ✤ Allowed number of statements per line

**There MUST NOT be more than one statement per line.**
[🔗](https://www.php-fig.org/per/coding-style/#23-lines)

**`index.php`**

```php
<?php

require_once(__DIR__ . '/../vendor/autoload.php');
require_once('structure.php');
require_once('view.php');

```

## Indenting

##### ✤ Indenting character

**Code MUST use `spaces` for indenting and MUST NOT use tabs for indenting.**
[🔗](https://www.php-fig.org/per/coding-style/#24-indenting)

##### ✤ Indenting length

**Code MUST use an indent of `4` spaces for each indent level.**
[🔗](https://www.php-fig.org/per/coding-style/#24-indenting)

**`HtmlDoc.php`**

```php
<?php

declare(strict_types=1);

namespace PHPLab\StandardPERCS;

use PHPLab\StandardPERCS\HtmlDocAuthor;

class HtmlDoc
{
    public $languageCode = 'en-GB';
    public $charset = 'utf-8';
    public $language = 'english';
    public $description = 'PER Coding Style example document';
    public $keywords = 'php,psr,per';
    public $author;
    public $title = 'Some PER Coding Style example page';
    public $header = 'PER Coding Style example';
    public $footer = 'Copyright PHP.PER.3.0.lab 2026';
    public $content = 'Hi, there!';

    public function setAuthor(HTMLDocAuthor &$htmlDocAuthor)
    {
        $this->author = [
            'name' => $htmlDocAuthor->name,
            'email' => $htmlDocAuthor->email,
        ];
    }
}

```

## Header of a PHP file

##### ✤ Header of a PHP file contents

**The header of a PHP file may consist of a number of different blocks.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

##### ✤ Blank line separators of the blocks in a header of a PHP file

**If present, each of the blocks (below) MUST be separated by a single blank line and MUST not contain a blank line.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

##### ✤ Order of the blocks in a header of a PHP file

**Each block MUST be in the order listed below, although blocks that are not relevant may be omitted:**
* **Opening `<?php` tag.**
* **File-level docblock.**
* **One or more declare statements.**
* **The namespace declaration of the file.**
* **One or more class-based use import statements.**
* **One or more function-based use import statements.**
* **One or more constant-based use import statements.**
* **The remainder of the code in the file.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**`HtmlDoc.php`**

```php
<?php

/*
 * This file is part of the PHP.lab package.
 *
 * (c) 2026 Katarzyna Krasińska <katheroine@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace PHPLab\StandardPSR12;

use PHPLab\StandardPSR12\HtmlDocAuthor;

class HtmlDoc
{
}

```

##### ✤ Header of the files with mix of HTML and PHP

**When a file contains a mix of HTML and PHP, any of the above sections may still be used.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**If so, they MUST be present at the top of the file, even if the remainder of the code consists of a closing PHP tag and then a mixture of HTML and PHP.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**`view.php`**

```php
<?php

/*
 * This file is part of the PHP.lab package.
 *
 * (c) 2026 Katarzyna Krasińska <katheroine@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

declare(strict_types=1);

namespace PHPLab\StandardPERCS;

use PHPLab\StandardPERCS\HtmlDocAuthor;

$htmlDoc = new HtmlDoc();
$htmlDocAuthor = new HtmlDocAuthor();
$htmlDoc->setAuthor($htmlDocAuthor);

?>
<!doctype html>
<html lang="<?= $htmlDoc->languageCode ?>">
  <head>
    <meta charset="<?= $htmlDoc->charset ?>">
    <meta name="language" content="<?= $htmlDoc->language ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?= $htmlDoc->description ?>">
    <meta name="keywords" content="<?= $htmlDoc->keywords ?>">
    <meta name="author" content="<?= $htmlDoc->author['name'] ?> <<?= $htmlDoc->author['email'] ?>>">
    <title><?= $htmlDoc->title ?></title>
  </head>
  <body>
    <?php if (isset($htmlDoc->header)): ?>
    <header>
        <?= $htmlDoc->header ?>
    </header>
    <?php endif; ?>
    <?php if (isset($htmlDoc->content)): ?>
    <div id="content">
        <?= $htmlDoc->content ?>
    </div>
    <?php endif; ?>
    <?php if (isset($htmlDoc->footer)): ?>
    <footer>
        <?= $htmlDoc->footer ?>
    </footer>
    <?php endif; ?>
  </body>
</html>

```

##### ✤ Opening `<?php` tag

**When the opening `<?php` tag is on the first line of the file, it MUST be on its own line with no other statements unless it is a file containing markup outside of PHP opening and closing tags.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**`<?php` tag MUST always be lower case.**
[🔗]()

## Directives

##### ✤ Declare statements formatting

**Declare statements MUST contain no spaces and MUST be exactly `declare(strict_types=1)` (with an optional semi-colon terminator).**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**`HtmlDocAuthor.php`**

```php
<?php

declare(strict_types=1);

namespace PHPLab\StandardPERCS;

class HtmlDocAuthor
{
    const EMAIL_DOMAIN = 'php.lab';

    public $name = 'Some Author';
    public $email = 'author@' . self::EMAIL_DOMAIN;
}

```

##### ✤ Block declare statements formatting

**Block declare statements are allowed and MUST be formatted as below. Note position of braces and spacing:**
```php
declare(ticks=1) {

    // some code

}
```
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

##### ✤ Strict types declaration formatting in files containing markup outside PHP opening and closing tags

**When wishing to declare strict types in files containing markup outside PHP opening and closing tags, the declaration MUST be on the first line of the file and include an opening PHP tag, the strict types declaration and closing tag.**

For example:

```php
<?php declare(strict_types=1) ?>
<html>
<body>
    <?php
        // ...
    ?>
</body>
</html>
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

**`view.php`**

```php
<?php declare(strict_types=1) ?>
<!doctype html>
<html lang="<?= $htmlDoc->languageCode ?>">
  <head>
    <meta charset="<?= $htmlDoc->charset ?>">
    <meta name="language" content="<?= $htmlDoc->language ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?= $htmlDoc->description ?>">
    <meta name="keywords" content="<?= $htmlDoc->keywords ?>">
    <meta name="author" content="<?= $htmlDoc->author['name'] ?> <<?= $htmlDoc->author['email'] ?>>">
    <title><?= $htmlDoc->title ?></title>
  </head>
  <body>
    <?php if (isset($htmlDoc->header)): ?>
    <header>
        <?= $htmlDoc->header ?>
    </header>
    <?php endif; ?>
    <?php if (isset($htmlDoc->content)): ?>
    <div id="content">
        <?= $htmlDoc->content ?>
    </div>
    <?php endif; ?>
    <?php if (isset($htmlDoc->footer)): ?>
    <footer>
        <?= $htmlDoc->footer ?>
    </footer>
    <?php endif; ?>
  </body>
</html>

```

## Imports

##### ✤ Use declarations placement

**Import statements MUST never begin with a leading backslash.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

* Wrong:

```php
use \PHPLab\StandardPERCS\HtmlDoc;
use \PHPLab\StandardPERCS\HtmlDocAuthor;
```

* Right:

```php
use PHPLab\StandardPERCS\HtmlDoc;
use PHPLab\StandardPERCS\HtmlDocAuthor;
```

##### ✤ Fully qualified import statements

**Import statements MUST always be fully qualified.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

The following example illustrates a complete list of all blocks:

```php
<?php

/**
 * This file contains an example of coding styles.
 */

declare(strict_types=1);

namespace Vendor\Package;

use Vendor\Package\{ClassA as A, ClassB, ClassC as C};
use Vendor\Package\SomeNamespace\ClassD as D;
use Vendor\Package\AnotherNamespace\ClassE as E;
use SomeVendor\Pack\ANamespace\SubNamespace\ClassF;

use function Vendor\Package\{functionA, functionB, functionC};
use function Another\Vendor\functionD;

use const Vendor\Package\{CONSTANT_A, CONSTANT_B, CONSTANT_C};
use const Another\Vendor\CONSTANT_D;

/**
 * FooBar is an example class.
 */
class FooBar
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

* Wrong:

```php
use StandardPERCS\HtmlDoc;
use HtmlDocAuthor;
```

* Right:

```php
use PHPLab\StandardPERCS\HtmlDoc;
use PHPLab\StandardPERCS\HtmlDocAuthor;
```

##### ✤ Import with compound namespaces

**When using compound namespaces, there MUST NOT be more than two sub-namespaces within the group.**
[🔗](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

That is, the following is allowed:

```php
<?php

use Vendor\Package\SomeNamespace\{
    SubnamespaceOne\ClassA,
    SubnamespaceOne\ClassB,
    SubnamespaceTwo\ClassY,
    ClassZ,
};
```

And the following would not be allowed:

```php
<?php

use Vendor\Package\SomeNamespace\{
    // This has too many namespace segments to be in a group
    SubnamespaceOne\AnotherNamespace\ClassA,
    SubnamespaceOne\ClassB,
    ClassZ,
};
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#3-declare-statements-namespace-and-import-statements)

* Right:

```php
use PHPLab\StandardPSR12\{
    HtmlDoc,
    HtmlDocAuthor,
    Language\EngGBLangTrait
};
```

```php
use PHPLab\{
    StandardPSR12\HtmlDoc,
    StandardPSR12\HtmlDocAuthor
};

use PHPLab\StandardPSR12\Language\EngGBLangTrait;
```

* Wrong:

```php
use PHPLab\{
    StandardPSR12\HtmlDoc,
    StandardPSR12\HtmlDocAuthor,
    StandardPSR12\Language\EngGBLangTrait
};
```

## Keywords, types & predefined constants

### Keywords

##### ✤ Keywords case

**All PHP reserved keywords MUST be in `lower case`.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

**Any new keywords added to future PHP versions MUST be in lower case.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

The PHP constants `true`, `false`, and `null` should be in `lower case` too.

### Types

##### ✤ Types case

**All PHP reserved types MUST be in `lower case`.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

**Any new types added to future PHP versions MUST be in lower case.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Types short/long forms

**Short form of type keywords MUST be used i.e. `bool` instead of `boolean`, `int` instead of `integer` etc.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

**`User.php`**

```php
class User
{
    public bool $registered = true;
    public int $level = 10;
}
```

##### ✤ Compound types structuring

**Compound types** includes *intersection*, *union*, and mixed intersection and union type declarations.

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

**PHP requires that all compound types be structured as an ORed (unioned) series of ANDs (intersections).**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Intersection type structuring in series

**And that each set of intersections be encased with parentheses.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Leading whitespaces at the begining of compound type symbol

**The union symbol | and intersection symbol & MUST NOT have a leading space.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Trailing whitespaces at the end of compound type symbol

**The union symbol | and intersection symbol & MUST NOT have a trailing space.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Leading whitespaces at the begining of compound type parenthesis

**The parentheses MUST NOT have a leading space.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Trailing whitespaces at the end of compound type parenthesis

**The parentheses MUST NOT have a trailing space.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Spliting a compound type with only intersections or only unions into multiple lines

**If it is necessary to split a compound type into multiple lines and the type contains only intersections or only unions, then each line MUST have a single type.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Spliting a compound type with both intersections and unions into multiple lines

**If it is necessary to split a compound type into multiple lines and the type contains both intersections and unions, then each line MUST have a single union segment.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

**All intersections in a segment MUST be on the same line.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Spliting a compound type and its symbol placement

**The symbol on which the compound type is split MUST be at the start of each line.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

The following are correct ways to format compound types:

```php
function foo(int|string $a): User|Product
{
    // ...
}

function somethingWithReflection(
    \ReflectionObject
    |\ReflectionClass
    |\ReflectionMethod
    |\ReflectionParameter
    |\ReflectionProperty $reflect
): object|null {
        // ...
}

function complex(array|(ArrayAccess&Traversable) $input): ArrayAccess&Traversable
{
    // ...
}

function veryComplex(
    array
    |(ArrayAccess&Traversable)
    |(Traversable&Countable) $input): ArrayAccess&Traversable
{
    // ...
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Union type with null

**If one of the ORed conditions is null, it MUST be the last item in the list.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

##### ✤ Intersection type with null

**An intersection of a single simple type with null SHOULD be abbreviated using the ? alternate syntax: ?T.**
[🔗](https://www.php-fig.org/per/coding-style/#25-keywords-and-types)

## Trailing commas

Numerous PHP constructs allow a sequence of values to be separated by a comma, and the final item may have an optional comma. Examples include array key/value pairs, function arguments, closure use statements, `match()` statement branches, etc.

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#26-trailing-commas)

**If that list is contained on a single line, then the last item MUST NOT have a trailing comma.**
[🔗](https://www.php-fig.org/per/coding-style/#26-trailing-commas)

**If the list is split across multiple lines, then the last item MUST have a trailing comma.**
[🔗](https://www.php-fig.org/per/coding-style/#26-trailing-commas)

The following are examples of correct comma placement:

```php
function beep(string $a, string $b, string $c)
{
    // ...
}

function beep(
    string $a,
    string $b,
    string $c,
) {
    // ...
}

$arr = ['a' => 'A', 'b' => 'B', 'c' => 'C'];

$arr = [
    'a' => 'A',
    'b' => 'B',
    'c' => 'C',
];

$result = match ($a) {
    'foo' => 'Foo',
    'bar' => 'Bar',
    default => 'Baz',
};
```

## Naming

This PSR RECOMMENDS following the php-src coding standards with regard to abbreviations and acronyms.

Specifically:

**Abbreviations and acronyms as well as initialisms SHOULD be avoided wherever possible, unless they are much more widely used than the long form (e.g. HTTP or URL).**
[🔗](https://www.php-fig.org/per/coding-style/#26-trailing-commas)

**Abbreviations, acronyms, and initialisms SHOULD be treated like regular words, thus they SHOULD be written with an uppercase first character, followed by lowercase characters.**
[🔗](https://www.php-fig.org/per/coding-style/#26-trailing-commas)

## Heredoc & nowdoc

##### ✤ Heredoc and nowdoc use cases

**A nowdoc SHOULD be used wherever possible. Heredoc MAY be used when a nowdoc does not satisfy requirements.**
[🔗](https://www.php-fig.org/per/coding-style/#10-heredoc-and-nowdoc)

##### ✤ Heredoc and nowdoc indentation variation

**Heredoc and nowdoc syntax is largely governed by PHP requirements with the only allowed variation being indentation.**
[🔗](https://www.php-fig.org/per/coding-style/#10-heredoc-and-nowdoc)

##### ✤ Heredoc and nowdoc declaration beginning placement

**Declared heredocs or nowdocs MUST begin on the same line as the context the declaration is being used in.**
[🔗](https://www.php-fig.org/per/coding-style/#10-heredoc-and-nowdoc)

##### ✤ Heredoc and nowdoc subsequent lines indentation

**Subsequent lines in the heredoc or nowdoc MUST be indented once past the scope indentation they are declared in.**
[🔗](https://www.php-fig.org/per/coding-style/#10-heredoc-and-nowdoc)

The following is not allowed due to the heredoc beginning on a different line than the context it's being declared in:

```php
$notAllowed =
<<<'COUNTEREXAMPLE'
    This
    is
    not
    allowed.
    COUNTEREXAMPLE;
```

Instead, the heredoc MUST be declared on the same line as the variable declaration it's being set against.

The following is not allowed due to the scope indention not matching the scope the heredoc is declared in:

```php
function notAllowed()
{
    $notAllowed = <<<'COUNTEREXAMPLE'
This
is
not
allowed.
COUNTEREXAMPLE;
}
```

Instead, the heredoc MUST be indented once past the indentation of the scope it's declared in.

The following is an example of both heredocs and nowdocs declared in a compliant way:

```php
function allowed()
{
    $allowedHeredoc = <<<COMPLIANT
        This
        is
        a
        compliant
        heredoc
        COMPLIANT;

    $allowedNowdoc = <<<'COMPLIANT'
        This
        is
        a
        compliant
        nowdoc
        COMPLIANT;

    var_dump(
        'foo',
        <<<'COMPLIANT'
            This
            is
            a
            compliant
            parameter
            COMPLIANT,
        'bar',
    );
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#10-heredoc-and-nowdoc)

## Operators

Style rules for operators are grouped by arity (the number of operands they take).

When space is permitted around an operator, multiple spaces MAY be used for readability purposes.

All operators not described here are left undefined.

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#6-operators)

### Operator's placement

##### ✤ Splitting statement with operator into multiple lines

**A statement that includes an operator MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#64-operators-placement)

##### ✤ Operator placement in statement splitted into multiple lines

**When doing so, the operator MUST be placed at the beginning of the new line; ternaries MUST occupy 3 lines, never 2.**
[🔗](https://www.php-fig.org/per/coding-style/#64-operators-placement)

For example:

```php
<?php

$variable1 = $ternaryOperatorExpr
    ? 'fizz'
    : 'buzz';

$variable2 = $possibleNullableExpr
    ?? 'fallback';

$variable3 = $elvisExpr
    ?: 'qix';
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#64-operators-placement)

##### ✤ Multiple spaces around an operator

**When space is permitted around an operator, multiple spaces MAY be used for readability purposes.**
[🔗](https://www.php-fig.org/psr/psr-12/#6-operators)

```php
$this->email = 'author@'
    . self::EMAIL_DOMAIN;
```

### Unary operators

##### ✤ Space between the operator and operand in the increment & decrement operators

**The increment/decrement operators MUST NOT have any space between the operator and operand.**
[🔗](https://www.php-fig.org/per/coding-style/#61-unary-operators)

```php
$i++;
++$j;
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#61-unary-operators)

```php
$this->level++;
```

##### ✤ Space within the parentheses in type casting operators

**Type casting operators MUST NOT have any space within the parentheses and MUST be separated from the variable they are operating on by exactly one space.**
[🔗](https://www.php-fig.org/psr/psr-12/#6-operators)

```php
$intValue = (int) $input;
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#61-unary-operators)

```php
$isWorking = (bool) $this->level;
```

### Binary operators

##### ✤ Spaces around the binary arithmetic, comparison, assignment, bitwise, logical, string, and type operators

**All binary arithmetic, comparison, assignment, bitwise, logical, string, and type operators MUST be preceded and followed by at least one space.**
[🔗](https://www.php-fig.org/per/coding-style/#62-binary-operators)

```php
if ($a === $b) {
    $foo = $bar ?? $a ?? $b;
} elseif ($a > $b) {
    $foo = $a + $b * $c;
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#62-binary-operators)

```php
$this->email = 'author@' . self::EMAIL_DOMAIN;
```

### Ternary operators

When the middle operand of the conditional operator is omitted, the operator MUST follow the same style rules as other binary comparison operators:

$variable = $foo ?: 'bar';

##### ✤ Spaces around the characters of the conditional operator

**The conditional operator, also known simply as the ternary operator, MUST be preceded and followed by at least one space around both the `?` and `:` characters.**
[🔗](https://www.php-fig.org/per/coding-style/#63-ternary-operators)

```php
$variable = $foo ? 'foo' : 'bar';
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#63-ternary-operators)

```php
$label = empty($this->nickname) ? $this->firstName : $this->nickname;
```

##### ✤ Spaces around the characters of the conditional operator when the middle operand is omitted

**When the middle operand of the conditional operator is omitted, the operator MUST follow the same style rules as other binary comparison operators.**
[🔗](https://www.php-fig.org/psr/psr-12/#63-ternary-operators)

```php
$isActive = $this->isRegistered ?: (bool) $this->level;
```

## Control structures

##### ✤ Space after control structure keyword

**There MUST be one space after the control structure keyword.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Space after opening parethensis in control structure

**There MUST NOT be a space after the opening parenthesis.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Space before closing parethensis in control structure

**There MUST NOT be a space before the closing parenthesis.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Space between closing parethensis and opening brace

**There MUST be one space between the closing parenthesis and the opening brace.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Closing brace placement in control structure

**The closing brace MUST be on the next line after the body.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Control structure body indention

**The structure body MUST be indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Control structure body placement

**The body MUST be on the next line after the opening brace.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

##### ✤ Control structure body enclosed by braces to indicate control structure body regardless of the number of statements it contains

**The body of each structure MUST be enclosed by braces.**
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

*This standardizes how the structures look and reduces the likelihood of introducing errors as new lines get added to the body.*
[🔗](https://www.php-fig.org/per/coding-style/#5-control-structures)

```php
if (! $this->isRegistered) {
    $status = self::STATUS_HALTING;
} elseif ($this->level > 10) {
    $status = self::STATUS_INVOLVED;
} else {
    $status = self::STATUS_CERTAIN;
}
```

### Control structure `if` - `elseif` - `else`

An if structure looks like the following. Note the placement of parentheses, spaces, and braces; and that else and elseif are on the same line as the closing brace from the earlier body.

```php
<?php

if ($expr1) {
    // ...
} elseif ($expr2) {
    // ...
} else {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

##### ✤ Keywords `else if` or keyword `elseif`

**The keyword `elseif` SHOULD be used instead of `else if` so that all control keywords look like single words.**
[🔗](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

* Wrong:

```php
if (! $this->isRegistered) {
    $status = self::STATUS_HALTING;
} else if ($this->level > 10) {
    $status = self::STATUS_INVOLVED;
} else {
    $status = self::STATUS_CERTAIN;
}
```

* Right:

```php
if (! $this->isRegistered) {
    $status = self::STATUS_HALTING;
} elseif ($this->level > 10) {
    $status = self::STATUS_INVOLVED;
} else {
    $status = self::STATUS_CERTAIN;
}
```

##### ✤ Splitting expression in parentheses across multiple lines

**Expressions in parentheses MAY be split across multiple lines, where each subsequent line is indented at least once.**
[🔗](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

##### ✤ First condition placement when expression is split across multiple lines

**When doing so, the first condition MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

##### ✤ Closing parenthesis and opening brace placement when expression is split across multiple lines

**The closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

**The closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**

##### ✤ Boolean operators between conditions placement when expression is split across multiple lines

**Boolean operators between conditions MUST always be at the beginning**
[🔗](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

For example:

```php
<?php

if (
    $expr1
    && $expr2
) {
    // ...
} elseif (
    $expr3
    && $expr4
) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#51-if-elseif-else)

```php
if (
    $this->isRegistered
    && $this->level > 10
) {
    $status = self::STATUS_INVOLVED;
}
```

### Control structure `switch` - `case`

A switch structure looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

switch ($expr) {
    case 0:
        echo 'First case, with a break';
        break;
    case 1:
        echo 'Second case, which falls through';
        // no break
    case 2:
    case 3:
    case 4:
        echo 'Third case, return instead of break';
        return;
    default:
        echo 'Default case';
        break;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

##### ✤ Statement case indention

**The `case` statement MUST be indented once from `switch`.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

##### ✤ Keyword break indention

**The `break` keyword (or other terminating keywords) MUST be indented at the same level as the `case` body.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

```php
switch ($status) {
    case self::STATUS_HALTING:
        $description = "Started to use the application.";
        break;
}
```

##### ✤ Comment when fall-through is intentional in a non-empty case body

**There MUST be a comment such as `// no break` when fall-through is intentional in a non-empty case body.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

```php
switch ($status) {
    case self::STATUS_HALTING:
        // the same as following;
    case self::STATUS_CERTAIN:
        $description = "Using the application.";
        break;
}
```

##### ✤ Splitting expression in parentheses across multiple lines

**Expressions in parentheses MAY be split across multiple lines, where each subsequent line is indented at least once.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

##### ✤ First condition placement when expression is split across multiple lines

**When doing so, the first condition MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

##### ✤ Closing parenthesis and opening brace placement when expression is split across multiple lines

**The closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

##### ✤ Boolean operators between conditions placement when expression is split across multiple lines

**Boolean operators between conditions MUST always be at the beginning.**
[🔗](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

For example:

```php
<?php

switch (
    $expr1
    && $expr2
) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

```php
switch (
    (bool) $status
    && $this->isRegistered
) {
}
```

### Control structure `match`

Similarly, a match expression looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

$returnValue = match ($expr) {
    0 => 'First case',
    1, 2, 3 => multipleCases(),
    default => 'Default case',
};
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#52-switch-case-match)

### Control structure `while`, `do` - `while`

A while statement looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

while ($expr) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#53-while-do-while)

#### Control structure `while`
Boolean operators between conditions MUST always be at the beginning.
##### ✤ Splitting expression in parentheses across multiple lines

**Expressions in parentheses MAY be split across multiple lines, where each subsequent line is indented at least once.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ First condition placement when expression is split across multiple lines

**When doing so, the first condition MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ Closing parenthesis and opening brace placement when expression is split across multiple lines

**The closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ Boolean operators between conditions placement when expression is split across multiple lines

**Boolean operators between conditions MUST always be at the beginning.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

```php
<?php

while (
    $expr1
    && $expr2
) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#53-while-do-while)

```php
while (
    $quantity > 0
    && $this->isRegistered
) {
}
```

#### Control structure `do` - `while`

Similarly, a do while statement looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

do {
    // ...
} while ($expr);

```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ Splitting expression in parentheses across multiple lines

**Expressions in parentheses MAY be split across multiple lines, where each subsequent line is indented at least once.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ First condition placement when expression is split across multiple lines

**When doing so, the first condition MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

##### ✤ Boolean operators between conditions placement when expression is split across multiple lines

**Boolean operators between conditions MUST always be at the beginning.**
[🔗](https://www.php-fig.org/per/coding-style/#53-while-do-while)

For example:

```php
<?php

do {
    // ...
} while (
    $expr1
    && $expr2
);
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#53-while-do-while)

```php
do {
} while (
    $upgrade > 0
    && $this->isRegistered
);

```

### Control structure `for`

A for statement looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

for ($i = 0; $i < 10; $i++) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#54-for)

```php
for ($i = 1; $i <= $skillsCount; $i++) {
    $visualisation .= $i . '. ' . $skills[$i - 1] . ', ';
}
```

##### ✤ Splitting expression in parentheses across multiple lines

**Expressions in parentheses MAY be split across multiple lines, where each subsequent line is indented at least once.**
[🔗](https://www.php-fig.org/per/coding-style/#54-for)

##### ✤ First expression placement when expression is split across multiple lines

**When doing so, the first expression MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#54-for)

##### ✤ Closing parenthesis and opening brace placement when expression is split across multiple lines

**The closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#54-for)

For example:

```php
<?php

for (
    $i = 0;
    $i < 10;
    $i++
) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#54-for)

```php
for (
    $i = 1;
    $i <= $skillsCount;
    $i++) {
}
```

### Control structure `foreach`

A foreach statement looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

foreach ($iterable as $key => $value) {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#55-foreach)

```php
foreach ($this->skills as $skillCodename => $skill) {
    $skillPresentation($skillCodename, $skill);
}
```

### Control structure `try` - `catch` - `finally`

A `try-catch-finally` block looks like the following. Note the placement of parentheses, spaces, and braces.

```php
<?php

try {
    // ...
} catch (FirstThrowableType $e) {
    // ...
} catch (OtherThrowableType|AnotherThrowableType $e) {
    // ...
} finally {
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#56-try-catch-finally)

## Closures & functions

##### ✤ Space after `function` keyword in closure definition

**Closures, also known as anonymous functions, MUST be declared with a space after the function keyword.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space before and after the `use` keyword in closure definition

**And a space before and after the `use` keyword.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space after function name in function definition

**Function names MUST NOT be declared with space after the method name.**
[🔗](https://www.php-fig.org/psr/psr-12/#44-methods-and-functions)

```php
function separate()
{
    print('<br>');
}
```

### Argument list

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public function foo(int $arg1, &$arg2, $arg3 = [])
    {
        // method body
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)

##### ✤ Space after opening parethensis of argument list in closure definition/call

**There MUST NOT be a space after the opening parenthesis of the argument list.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space before closing parethensis of argument list in closure definition/call

**There MUST NOT be a space before the closing parenthesis of the argument list.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space before coma on argument list in closure definition/call

**In the argument list, there MUST NOT be a space before each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space after coma on argument list in closure definition/call

**In the argument list, there MUST be one space after each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

```php
<?php

bar();
$foo->bar($arg1);
Foo::bar($arg2, $arg3);
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#44-methods-and-functions)

`function ($skillCodename, $skill)`

##### ✤ Closure arguments with default values placement in closure definition/call

**Closure arguments with default values MUST go at the end of the argument list.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

`function ($skillCodename = 'programming', $skill = ['name' => 'Programming', 'level' => 3])`

##### ✤ List of function/closure arguments split acros multi lines in closure definition/call

**Argument lists MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)
[🔗](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)
[🔗](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

##### ✤ Arguments placement on list of function/closure arguments split acros multi lines in closure definition/call

**When doing so, the first item in the list MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)
[🔗](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)
[🔗](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

```php
<?php

$foo->bar(
    $longArgument,
    $longerArgument,
    $muchLongerArgument
);
<?php

somefunction($foo, $bar, [
  // ...
], $baz);

$app->get('/hello/{name}', function ($name) use ($app) {
    return 'Hello ' . $app->escape($name);
});
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

##### ✤ Number of arguments per line on list of function/closure arguments split acros multi lines in closure definition/call

**There MUST be only one argument per line.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)
[🔗](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)
[🔗](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

##### ✤ Closing parenthesis and opening brace in closure with list of closure arguments split acros multi lines in closure definition/call

**When the argument list is split across multiple lines, the closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public function aVeryLongMethodName(
        ClassTypeHint $arg1,
        &$arg2,
        array $arg3 = []
    ) {
        // method body
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)

```php
function (
    $skillCodename,
    $skill
) {
}
```

### Keyword `use`

The following are examples of closures with and without argument lists and variable lists split across multiple lines.
##### ✤ Space before `use` keyword in closure definition

**Closures MUST be declared with a space before the `use` keyword.**
[🔗](https://www.php-fig.org/psr/psr-12/#7-closures)

##### ✤ Space after `use` keyword in closure definition

**Closures MUST be declared with a space after the `use` keyword.**
[🔗](https://www.php-fig.org/psr/psr-12/#7-closures)

##### ✤ Keyword `use` in closure declaration

**If the `use` keyword is present, the colon MUST follow the use list closing parentheses with no spaces between the two characters.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

A closure declaration looks like the following. Note the placement of parentheses, commas, spaces, and braces:

```php
<?php

$closureWithArgs = function ($arg1, $arg2) {
    // ...
};

$closureWithArgsAndVars = function ($arg1, $arg2) use ($var1, $var2) {
    // ...
};

$closureWithArgsVarsAndReturn = function ($arg1, $arg2) use ($var1, $var2): bool {
    // ...
};
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#7-closures)

### Variable list

##### ✤ Space after opening parethensis of variable list in closure definition/call

**There MUST NOT be a space after the opening parenthesis of the variable list.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space before closing parethensis of variable list in closure definition/call

**There MUST NOT be a space before the closing parenthesis of the variable list.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space before coma on variable list in closure definition/call

**In the variable list, there MUST NOT be a space before each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space after coma on variable list in closure definition/call

**In the variable list, there MUST be one space after each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

`function ($skillCodename, $skill) use ($levelMarkChar, $newLineSeq)`

##### ✤ List of closure variables split acros multi lines in closure definition/call

**Variable lists MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Variables placement in list of closure variables split acros multi lines in closure definition/call

**When doing so, the first item in the list MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Number of variables per line on list of closure variables split acros multi lines in closure definition/call

**There MUST be only one variable per line.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Closing parenthesis and opening brace in closure with list of closure variables split acros multi lines in closure definition/call

**When the ending list of variables is split across multiple lines, the closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

```php
function ($skillCodename, $skill) use (
    $levelMarkChar,
    $newLineSeq
) {
}
```

The following are examples of closures with and without argument lists and variable lists split across multiple lines.

```php
<?php

$longArgs_noVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument,
) {
   // ...
};

$noArgs_longVars = function () use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3,
) {
   // ...
};

$longArgs_longVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument,
) use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3,
) {
   // ...
};

$longArgs_shortVars = function (
    $longArgument,
    $longerArgument,
    $muchLongerArgument,
) use ($var1) {
   // ...
};

$shortArgs_longVars = function ($arg) use (
    $longVar1,
    $longerVar2,
    $muchLongerVar3,
) {
   // ...
};
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#7-closures)

Note that the formatting rules also apply when the closure is used directly in a function or method call as an argument.

```php
<?php

$foo->bar(
    $arg1,
    function ($arg2) use ($var1) {
        // ...
    },
    $arg3,
);
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Space between method name and opening parenthesis in function call

**When making a function call, there MUST NOT be a space between the method or function name and the opening parenthesis.**
[🔗](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

```php
$skillPresentation($skillCodename, $skill);
```

### Braces

##### ✤ Opening brace placement in closure definition/call

**The opening brace MUST go on the same line.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

##### ✤ Closing brace placement in closure definition/call

**Closing brace MUST go on the next line following the body.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

```php
function ($skillCodename, $skill) use (
    $levelMarkChar,
    $newLineSeq
) {
}
```

### Keyword `return`

##### ✤ Return type declaration in closure definition

**If a return type is present, it MUST follow the same rules as with normal functions and methods.**
[🔗](https://www.php-fig.org/per/coding-style/#7-closures)

`function ($skillCodename, $skill) use ($levelMarkChar, $newLineSeq): void`

A closure declaration looks like the following. Note the placement of parentheses, commas, spaces, and braces:

```php
<?php

$closureWithArgs = function ($arg1, $arg2) {
    // ...
};

$closureWithArgsAndVars = function ($arg1, $arg2) use ($var1, $var2) {
    // ...
};

$closureWithArgsVarsAndReturn = function ($arg1, $arg2) use ($var1, $var2): bool {
    // ...
};
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#7-closures)

A function declaration looks like the following. Note the placement of parentheses, commas, spaces, and braces:

```php
<?php

function fooBarBaz($arg1, &$arg2, $arg3 = [])
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

### Short closure form

##### ✤ Short closure form

**Short closures, also known as arrow functions, MUST follow the same guidelines and principles as long closures above, with the following additions.**
[🔗](https://www.php-fig.org/per/coding-style/#71-short-closures)

##### ✤ Short closure fn keyword and space

**The fn keyword MUST NOT be succeeded by a space.**
[🔗](https://www.php-fig.org/per/coding-style/#71-short-closures)

##### ✤ Short closure => symbol and spaces

**The => symbol MUST be preceded and succeeded by a space.**
[🔗](https://www.php-fig.org/per/coding-style/#71-short-closures)

##### ✤ Short closure expression semicolon and a space

**The semicolon at the end of the expression MUST NOT be preceded by a space.**
[🔗](https://www.php-fig.org/per/coding-style/#71-short-closures)

##### ✤ Short closure expression splitting into many lines

**The expression portion MAY be split to a subsequent line. If so, the => MUST be included on the second line, and MUST be indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#71-short-closures)

The following examples show proper common usage of short closures.

```php
$func = fn(int $x, int $y): int => $x + $y;

$func = fn(int $x, int $y): int
    => $x + $y;

$func = fn(
    int $x,
    int $y,
): int
    => $x + $y;

$result = $collection->reduce(fn(int $x, int $y): int => $x + $y, 0);
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

##### ✤ Function callable references

A function or method may be referenced in a way that creates a closure out of it, by providing `...` in place of arguments.

**If so, the `...` MUST NOT include any whitespace before or after. That is, the correct format is foo(...).**
[🔗](https://www.php-fig.org/per/coding-style/#48-function-callable-references)

## Enumerations

Enumerations (enums) MUST follow the same guidelines as classes, except where otherwise noted below.

Methods in enums MUST follow the same guidelines as methods in classes.

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#9-enumerations)

##### ✤ Non-public enum methods visibility

**Non-public methods MUST use private instead of protected, as enums do not support inheritance.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

##### ✤ Space between the enum name and colon in backed enum

**When using a backed enum, there MUST NOT be a space between the enum name and colon.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

##### ✤ Space between the colon and the backing type in backed enum

**There MUST be exactly one space between the colon and the backing type.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

This is consistent with the style for return types.

##### ✤ Enum case declaration case

**Enum case declarations MUST use PascalCase capitalization.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

##### ✤ Enum case declaration placement

**Enum case declarations MUST be on their own line.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

##### ✤ Enum constant case

**Constants in Enumerations MAY use either PascalCase or UPPER_CASE capitalization. PascalCase is RECOMMENDED, so that it is consistent with case declarations.**
[🔗](https://www.php-fig.org/per/coding-style/#9-enumerations)

The following example shows a typical valid Enum:

```php
enum Suit: string
{
    case Hearts = 'H';
    case Diamonds = 'D';
    case Spades = 'S';
    case Clubs = 'C';

    public const Wild = self::Spades;
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#9-enumerations)

## Classes

The term "class" refers to all classes, interfaces, traits, and enums.

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

### Declaring classes

##### ✤ Braces in empty class declaration

**If class contains no additional declarations (such as an exception that exists only to extend another exception with a new type), then the body of the class SHOULD be abbreviated as {} and placed on the same line as the previous symbol, separated by a space.**

For example:

```php
class MyException extends \RuntimeException {}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

### Instantiating classes

##### ✤ Parentheses in class instantiation

**When instantiating a new class, parentheses MUST always be present even when there are no arguments passed to the constructor.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

For example:

```php
new Foo();
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

##### ✤ Accessing a class member immediately after instantiating

**When accessing a class member immediately after instantiating a new class, the instantiation SHOULD NOT be wrapped in parentheses.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

For example:

```php
new Foo()->someMethod();
new Foo()->someStaticMethod();
new Foo()->someProperty;
new Foo()::someStaticProperty;
new Foo()::SOME_CONSTANT;
```

And the following SHOULD be avoided:

```php
(new Foo())->someMethod();
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

### Extending classes



The following is a validly formatted class:


##### ✤ Keyword `extends` placement in class definition

**The `extends` keyword MUST be declared on the same line as the class name.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements \ArrayAccess, \Countable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

```php
class User extends Technician
{
}
```

##### ✤ List of extends split acros multi lines in class definition

**Lists of extends (in the case of interfaces) MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

**When doing so, the first item in the list MUST be on the next line, and there MUST be only one interface per line.**
[🔗](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

```php
interface Evidentiable extends
    Presentable,
    Identifiable
{
}
```

### Implementing interfaces

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements \ArrayAccess, \Countable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

##### ✤ Keyword `implements` placement in class definition

**The `implements` keyword MUST be declared on the same line as the class name.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements \ArrayAccess, \Countable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

```php
class Person implements Presentable
{
}
```

##### ✤ List of `implements` split acros multi lines in class definition

**Lists of implements MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

**When doing so, the first item in the list MUST be on the next line, and there MUST be only one interface per line.**
[🔗](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

For example:

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

```php
class Person implements
    Presentable,
    Identifiable
{
}
```

##### ✤ Opening brace placement in class definition

**The opening brace for the class MUST go on its own line.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

**The opening brace for the class MUST NOT be preceded or followed by a blank line.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

##### ✤ Closing brace placement in class definition

**The closing brace for the class MUST go on its own line.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

**The closing brace line MUST immediately following the last line of the class body.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

**The closing brace line MUST NOT be preceded by a blank line.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)

**Any closing brace MUST NOT be followed by any comment or statement on the same line.**
[🔗](https://www.php-fig.org/per/coding-style/#4-classes-properties-and-methods)


The following is a validly formatted class:

```php
<?php

namespace Vendor\Package;

use FooClass;
use BarClass as Bar;
use OtherVendor\OtherPackage\BazClass;

class ClassName extends ParentClass implements \ArrayAccess, \Countable
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#41-extends-and-implements)

### Using traits

##### ✤ Keyword `use` placement in class definition

**The `use` keyword used inside the classes to implement traits MUST be declared on the next line after the opening brace.**
[🔗](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
<?php

namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
class Technician
{
    use Skilled;
}
```

##### ✤ Number of trait including per line in class definition

**Each individual trait that is imported into a class MUST be included one-per-line and each inclusion MUST have its own use import statement.**
[🔗](https://www.php-fig.org/per/coding-style/#42-using-traits)

The following is a correct example of trait usage.

```php
<?php

namespace Vendor\Package;

use Vendor\Package\FirstTrait;
use Vendor\Package\SecondTrait;
use Vendor\Package\ThirdTrait;

class ClassName
{
    use FirstTrait;
    use SecondTrait;
    use ThirdTrait;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
<?php

namespace Vendor\Package;

use Vendor\Package\FirstTrait;
use Vendor\Package\SecondTrait;
use Vendor\Package\ThirdTrait;

class ClassName
{
    use FirstTrait;
    use SecondTrait;
    use ThirdTrait;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
class Technician extends Person
{
    use Educated;
    use Skilled;
}
```

##### ✤ Closing brace after the use import placement in class definition

**When the class has nothing after the use import statement, the class closing brace MUST be on the next line after the use import statement.**
[🔗](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
<?php

namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

##### ✤ Blank line after the use import placement in class definition

**Otherwise, it MUST have a blank line after the use import statement.**
[🔗](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
<?php

namespace Vendor\Package;

use Vendor\Package\FirstTrait;

class ClassName
{
    use FirstTrait;

    private $property;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
class Technician extends Person
{
    use Educated;
    use Skilled;

    public function isVirtual(): bool
    {
        $isVirtual = ! empty($this->educations) && ! empty($this->skills);

        return $isVirtual;
    }
}
```

##### ✤ Keywords `insteadof` and `as`

**When using the `insteadof` and `as` operators they must be in separated lines with indentations.**
[🔗](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
<?php

class Talker
{
    use A;
    use B {
        A::smallTalk insteadof B;
    }
    use C {
        B::bigTalk insteadof C;
        C::mediumTalk as FooBar;
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#42-using-traits)

```php
class Technician extends Person
{
    use Educated {
        Educated::isVirtual insteadof Skilled;
    }

    use Skilled {
        Skilled::isVirtual as isSkilled;
    }
}
```

### Modifier keywords

Classes, properties, and methods have numerous keyword modifiers that alter how the engine and language handles them. When present, they MUST be in the following order:

* Inheritance modifier: abstract or final
* Visibility modifier: public, protected, or private
* Set-visibility modifier: public(set), protected(set), or private(set)
* Scope modifier: static
* Mutation modifier: readonly
* Type declaration
* Name

All keywords MUST be on a single line, and MUST be separated by a single space. All keywords MUST be all lower-case. The public keyword MAY be omitted when using a set-visibility on a public-read property.

The following is a correct example of modifier keyword usage:

```php
<?php

namespace Vendor\Package;

abstract class ClassName
{
    protected static string $foo;

    private readonly int $beep;

    protected private(set) string $name;

    protected(set) string $boop;

    abstract protected function zim();

    final public static function bar()
    {
        // ...
    }
}

readonly class ValueObject
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#46-modifier-keywords)

##### ✤ Keyword `abstract` placement

**When present, the `abstract` declarations MUST precede the visibility declaration.**
[🔗](https://www.php-fig.org/psr/psr-12/#46-abstract-final-and-static)

`abstract protected function hasMiddleName(): bool;`

##### ✤ Keyword `final` placement

**When present, the `final` declarations MUST precede the visibility declaration.**
[🔗](https://www.php-fig.org/psr/psr-12/#46-abstract-final-and-static)

`final public function isVirtual(): bool`

##### ✤ Keyword `static` placement

**When present, the `static` declaration MUST come after the visibility declaration.**
[🔗](https://www.php-fig.org/psr/psr-12/#46-abstract-final-and-static)

`public static function getCount(): int`

##### ✤ Keyword `readonly` palcement

**When present, the `readonly` declaration MUST come after the visibility declaration.**

`private readonly int $beep;`

### Class constants

##### ✤ Class constant visiblity declaration

**Visibility MUST be declared on all constants.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

```php
public const STATUS_HALTING = 'halting';
public const STATUS_CERTAIN = 'certain';
public const STATUS_INVOLVED = 'involved';
```

##### ✤ Class constant declarations per statement

**There MUST NOT be more than one constant declared per statement.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

##### ✤ Single underscore prefix in constant names for indication of non-public visibility

**Constant names MUST NOT be prefixed with a single underscore to indicate protected or private visibility.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

**That is, an underscore prefix explicitly has no meaning.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

### Class properties

##### ✤ Property visiblity declaration

**Visibility MUST be declared on all properties.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

```php
private static $count;
protected $isRegistered = false;
public $level = 0;
```

**If set-visibility is specified, then the general visibility MAY be omitted.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

##### ✤ Single underscore prefix in property names for indication of non-public visibility

**Property names MUST NOT be prefixed with a single underscore to indicate protected or private visibility.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

**That is, an underscore prefix explicitly has no meaning.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

* Wrong:

```php
private static $_count = 0;
protected $_isRegistered = false;
public $level = 0;
```

* Right:

```php
private static $count = 0;
protected $isRegistered = false;
public $level = 0;
```

##### ✤ Keyword `var` (used to declare property)

**The `var` keyword MUST NOT be used to declare a property.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

* Wrong:

```php
var static $count = 0;
var $isRegistered = false;
var $level = 0;
```

* Right:

```php
private static $count;
protected $isRegistered = false;
public $level = 0;
```

##### ✤ Property type declaration

**There MUST be a space between type declaration and property name.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

A property declaration looks like the following:

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public $foo = null;
    public static int $bar = 0;
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

```php
private static int $count = 0;
protected bool $isRegistered = false;
public int $level = 0;
```

##### ✤ Property declarations per statement

**There MUST NOT be more than one property declared per statement.**
[🔗](https://www.php-fig.org/per/coding-style/#43-properties-and-constants)

* Wrong:

```php
public int $level = 0, $score = 5;
```

* Right:

```php
public int $level = 0;
public int $score = 5;
```

### Class methods

##### ✤ Single underscore prefix in method names for indication of non-public visibility

**Method names MUST NOT be prefixed with a single underscore to indicate protected or private visibility.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

**That is, an underscore prefix explicitly has no meaning.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

* Wrong:

```php
protected function _hasMiddleName()
{
    return false;
}
```

* Right:

```php
protected function hasMiddleName()
{
    return false;
}
```

##### ✤ Method visiblity declaration

**Visibility MUST be declared on all methods.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

```php
abstract protected function hasMiddleName();

public function getName()
{
    $name = $firstName
        . $this->hasMiddleName() ? $this->middleName : ' '
        . $lastName;

    return $name;
}

public function getPesel()
{
    return $this->pesel;
}
```

##### ✤ Space after method name in method definition

**Method names MUST NOT be declared with space after the method name.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

`public function getPesel()`

##### ✤ Space after opening parethensis of argument list in method definition/call

**There MUST NOT be a space after the opening parenthesis.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

##### ✤ Space before closing parethensis of argument list in method definition/call

**There MUST NOT be a space before the closing parenthesis.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

A method declaration looks like the following. Note the placement of parentheses, commas, spaces, and braces:

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public function fooBarBaz($arg1, &$arg2, $arg3 = [])
    {
        // ...
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

##### ✤ Space before coma on argument list in method definition/call

**In the argument list, there MUST NOT be a space before each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

##### ✤ Space after coma on argument list in method definition/call

**In the argument list, there MUST be one space after each comma.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

The following lines show correct calls:

```php
<?php

bar();
$foo->bar($arg1);
Foo::bar($arg2, $arg3);
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#47-method-and-function-calls)

`public function setName($firstName, $middleName, $lastName)`

##### ✤ List of method arguments with reference operator

There MUST NOT be a space between the variadic three dot operator and the argument name:
**When using the reference operator & before an argument, there MUST NOT be a space after it.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

class ReturnTypeVariations
{
    public function functionName(?string $arg1, ?int &$arg2): ?string
    {
        return 'foo';
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

`public function setAuthor(HTMLDocAuthor &$htmlDocAuthor)`

##### ✤ List of method arguments with variadic three dot operator

**There MUST NOT be a space between the variadic three dot operator and the argument name.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

```php
public function process(string $algorithm, ...$parts)
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

`public function addEducations(...$educations)`

##### ✤ List of method arguments with reference and variadic three dot operators

**When combining both the reference operator and the variadic three dot operator, there MUST NOT be any space between the two of them.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

```php
public function process(string $algorithm, &...$parts)
{
    // ...
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

##### ✤ Method arguments with default values placement

**Method parameters with default values MUST go at the end of the argument list.**
[🔗](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)

For example:

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public function foo(int $arg1, &$arg2, $arg3 = [])
    {
        // ...
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

`public function setName($firstName, $lastName, $middleName = '')`

##### ✤ List of method arguments split acros multi lines in method definition/call

**Argument lists MAY be split across multiple lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

##### ✤ Arguments placement on list of method arguments split acros multi lines in method definition/call

**When doing so, the first item in the list MUST be on the next line, and there MUST be only one argument per line.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

##### ✤ Number of arguments per line on list of method arguments split acros multi lines in method definition/call

**There MUST be only one argument per line.**
[🔗](https://www.php-fig.org/psr/psr-12/#45-method-and-function-arguments)

##### ✤ Closing parenthesis and opening brace in method with list of method arguments split acros multi lines in method definition

**When the argument list is split across multiple lines, the closing parenthesis and opening brace MUST be placed together on their own line with one space between them.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

For example:

```php
<?php

namespace Vendor\Package;

class ClassName
{
    public function aVeryLongMethodName(
        ClassTypeHint $arg1,
        &$arg2,
        array $arg3 = [],
    ) {
        // ...
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

```php
public function setName(
    $firstName,
    $lastName,
    $middleName = '') {
}
```

##### ✤ Braces in empty method declaration

**If a method contains no statements or comments (such as an empty no-op implementation or when using constructor property promotion), then the body SHOULD be abbreviated as {} and placed on the same line as the previous symbol, separated by a space.**

For example:

```php
class Point
{
    public function __construct(private int $x, private int $y) {}

    // ...
}
```

```php
class Point
{
    public function __construct(
      public readonly int $x,
      public readonly int $y,
    ) {}
}
```

-- [PER Documentation](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

##### ✤ Single argument being split across multiple lines in method call

**A single argument being split across multiple lines (as might be the case with a closure or array) does not constitute splitting the argument list itself.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

```php
<?php

$foo->bar(
    $longArgument,
    $longerArgument,
    $muchLongerArgument,
);
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

##### ✤ Named argument in method call

**If using named arguments, there MUST NOT be a space between the argument name and colon.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

**And there MUST be a single space between the colon and the argument value**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

For example:

```php
somefunction($a, b: $b, c: 'c');
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

##### ✤ Method chaining

**Method chaining MAY be put on separate lines, where each subsequent line is indented once.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

**When doing so, the first method MUST be on the next line.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

For example:

```php
$someInstance
    ->create()
    ->prepare()
    ->run();
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

##### ✤ Return type declaration in method definition

**When you have a return type declaration present, there MUST be one space after the colon followed by the type declaration. The colon and declaration MUST be on the same line as the argument list closing parenthesis with no spaces between the two characters.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

For example:

```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

class ReturnTypeVariations
{
    public function functionName(int $arg1, $arg2): string
    {
        return 'foo';
    }

    public function anotherFunction(
        string $foo,
        string $bar,
        int $baz,
    ): string {
        return 'foo';
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

`public function getName(): string`

##### ✤ Return type declaration with nullable type in method definition

**In nullable type declarations, there MUST NOT be a space between the question mark and the type.**
[🔗](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

For example:

```php
<?php

declare(strict_types=1);

namespace Vendor\Package;

class ReturnTypeVariations
{
    public function functionName(?string $arg1, ?int &$arg2): ?string
    {
        return 'foo';
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#45-method-and-function-parameters)

`public function getPesel(): ?int`

##### ✤ Opening brace placement in method definition

**The opening brace MUST go on its own line.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

##### ✤ Closing brace placement in method definition

**The closing brace MUST go on the next line following the body.**
[🔗](https://www.php-fig.org/per/coding-style/#44-methods-and-functions)

##### ✤ Comments or statements following closing brace in method definition

**Any closing brace MUST NOT be followed by any comment or statement on the same line.**
[🔗](https://www.php-fig.org/psr/psr-12/#4-classes-properties-and-methods)

```php
public function getName(): string
{
}
```

##### ✤ Space between method name and opening parenthesis in method call

**When making a method call, there MUST NOT be a space between the method or function name and the opening parenthesis.**
[🔗](https://www.php-fig.org/per/coding-style/#47-method-and-function-calls)

```php
$htmlDoc->setAuthor($htmlDocAuthor);
```

### Class instantiating

##### ✤ Parentheses in class instantiating

**When instantiating a new class, parentheses MUST always be present even when there are no arguments passed to the constructor.**
[🔗](https://www.php-fig.org/psr/psr-12/#4-classes-properties-and-methods)

```php
new Foo();
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#4-classes-properties-and-methods)

```php
$user = new User();
```

### Anonymous classes

Anonymous Classes MUST follow the same guidelines and principles as closures in the above section.

```php
<?php

$instance = new class {};
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

##### ✤ Opening brace, class keyword and list of implements placement

**The opening brace MAY be on the same line as the class keyword so long as the list of implements interfaces does not wrap. If the list of interfaces wraps, the brace MUST be placed on the line immediately following the last interface.**
[🔗](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

```php
<?php

// Brace on the same line
$instance = new class extends \Foo implements \HandleableInterface {
    // Class content
};

// Brace on the next line
$instance = new class extends \Foo implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    // Class content
};
```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

```php
$human = new class {};
```

```php
$human = new class implements
    Identifiable,
    Presentable
{
};
```

### Property Hooks

Object properties may also include hooks, which have a number of syntactic options.

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Opening brace in the long form hook definition

**The opening brace MUST be on the same line as the property.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**The opening brace MUST be separated from the property name or its default value by a single space.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Closing brace in the long form hook definition

**The closing brace MUST be on its own line, and have no comment following it.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Body indentation in the long form hook definition

**The entire body of the hook definition MUST be indented one level.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**The body of each hook MUST be indented one level.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Multiple hook declaration

**If multiple hooks are declared, they MUST be separated by at least a single line break.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**They MAY be separated by an additional blank line to aid readability.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

For example:

```php
class Example
{
    public string $newName = 'Me' {
        set(string $value) {
            if (strlen($value) < 3) {
                throw new \Exception('Too short');
            }
            $this->newName = ucfirst($value);
        }
    }

    public string $department {
        get {
            return $this->values[__PROPERTY__];
        }
        set {
            $this->values[__PROPERTY__] = $value;
        }
    }
    // or
    public string $department {
        get {
            return $this->values[__PROPERTY__];
        }

        set {
            $this->values[__PROPERTY__] = $value;
        }
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

Property hooks also support multiple short-hook variations.

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Argument name and type in the short form set hook definition

**For a set hook, if the argument name and type do not need to be redefined, then they MAY be omitted.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**If a hook consists of a single expression, then PHP allows it to be shortened using =>.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Spaces around => symbol in the short form hook definition with =>

**There MUST be a single space on either side of the => symbol.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Body indentation in the short form hook definition with =>

**The body MUST begin on the same line as the hook name and =>.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**Wrapping is allowed if the expression used allows for wrapping, using the rules defined elsewhere in this document.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

```php
class Example
{
    public string $myName {
        get => __CLASS__;
    }

    public string $newName {
        set => ucfirst($value);
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

If there is only one hook implementation, that hook uses the short-hook syntax, that hook expression does not contain any wrapping, then the hook MAY be listed entirely inline.

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ The inline hook name and the opening brace separation

**The inline hook name MUST be separated from the opening brace and the arrow operator by a single space.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ The inline hook expression semicolon and the closing brace separation

**The semicolon ending of the inline hook MUST be separated from the closing brace by a single space.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

For example:

```php
class Example
{
    public string $myName { get => __CLASS__; }

    public string $newName { set => ucfirst($value); }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

##### ✤ Property hook and constructor-promoted property

**Property hooks MAY also be defined in constructor-promoted properties.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**However, they MUST be only a single hook, with a short-syntax body, defined on a single line as above.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

**If those criteria are not met, then the promoted property MUST NOT have any hooks defined inline.**
[🔗](https://www.php-fig.org/per/coding-style/#49-property-hooks)

```php
class Example
{
    public function __construct(
        public string $name { set => ucfirst($value); }
    ) {}
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

The following is not allowed due to the hook being too complex:

```php
class Example
{
    public function __construct(
        public string $name {
            set {
                if (strlen($value) < 3) {
                    throw new \Exception('Too short');
                }
                $this->newName = ucfirst($value);
            }
        }
    ) {}
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#49-property-hooks)

Abstract properties may be defined in interfaces or abstract classes, but are required to specify if they must support get operations, set operations, or both. In the case of abstract classes, they MAY include a body for one or another hook.

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property hook rules

**If there is a body for any hook, then the entire hook block MUST follow the same rules as for defined hooks above.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook

**The only difference is that a hook that has no body specified have a single semicolon after the hook keyword, with no space before it.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

```php
abstract class Example {
    abstract public string $name {
        get => ucfirst($this->name);
        set;
    }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook operation block

**If there is no body for either hook, the operation block MUST be on the same line as the property.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook and space between the property name and the operation block

**If there is no body for either hook, there MUST be a single space between the property name and the operation block {}.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook and space after the opening brace

**If there is no body for either hook, there MUST be a single space after the opening {.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook and space before the opening brace

**If there is no body for either hook, there MUST be a single space before the closing };**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook and space between the operation and the semicolon

**If there is no body for either hook, there MUST NOT be a space between the operation and its required semicolon.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook multiple operations

**If multiple operations are specified, they MUST be separated by a single space.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

##### ✤ Abstract property undefined hook operations precedence

**The get operation MUST be listed before the set operation.**
[🔗](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

```php
interface Example
{
    public string $readable { get; }

    public string $writeable { set; }

    public string $both { get; set; }
}
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#410-interface-and-abstract-properties)

### Anonymous classes

Anonymous Classes MUST follow the same guidelines and principles as closures in the above section.

```php
<?php

$instance = new class {};

```

-- [PSR Documentation](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

##### ✤ Opening brace, class keyword and list of implements placement

**The opening brace MAY be on the same line as the class keyword so long as the list of implements interfaces does not wrap.**
[🔗](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

##### ✤ Brace placement in the class implementing many interfaces

**If the list of interfaces wraps, the brace MUST be placed on the line immediately following the last interface.**
[🔗](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

##### ✤ Parenthensis in anonymous class with no arguments

**If the anonymous class has no arguments, the () after class MUST be omitted.**
[🔗](https://www.php-fig.org/psr/psr-12/#8-anonymous-classes)

For example:

```php
<?php

// Brace on the same line
// No arguments
$instance = new class extends \Foo implements \HandleableInterface {
    // ...
};

// Brace on the next line
// Constructor arguments
$instance = new class ($a) extends \Foo implements
    \ArrayAccess,
    \Countable,
    \Serializable
{
    public function __construct(public int $a)
    {
    }
    // ...
};
```

-- [PSR Documentation](https://www.php-fig.org/per/coding-style/#8-anonymous-classes)

```php
$human = new class {};
```

```php
$human = new class implements
    Identifiable,
    Presentable
{
};
```
