# Deployment Calendar Generator
A tool for generating a software release calendar starting from an arbitrary date. Intended for those who coordinate deployments of legacy applications with regularly scheduled downtime windows.

## Installation
```
bundle install
rake
```

## Usage
`./bin/generate-deployment-calendar.rb <VERSION> [start date]`

Where `<VERSION>` is a mandatory parameter specifying the version being released. This is used to name the output file, mapping `.` to `_` such that version `2.11.3` would create a file named `2_11_3.md`.

The start date is optional and can be expressed in any format understood by Ruby's [Date::parse](https://ruby-doc.org/stdlib/libdoc/date/rdoc/Date.html#method-c-parse) method. The current date is used if no starting date is specified.

## Configuration
The deployment template and configuration options can be found in the `cfg` directory. The options available for configuration are:

* `:columnSeparator` - defines the token delineating columns in the table;
* `:dateColumn` - the column whose entries will be convereted into calendar dates;
* `:dateColumnWidth ` - width, in characters, of the date column; and
* `:dateTimeFormat` - the Ruby [strftime](https://ruby-doc.org/core/Time.html#method-i-strftime) format to use for date output.

The date column in the template supports English Gregorian days of the week (Monday, Tuesday...) as well as "today" and "tomorrow". If today or tomorrow is specifed then the release start date is ignored.


## Example
Given the template:

```
|----------|----------|-------|------------------|----------------|
| Instance | Date     | Time  | Who              | Duration (min) |
|----------|----------|-------|------------------|----------------|
| STAGING  | TODAY    | 09:00 | @owl             |                |
| PREPROD  | TOMORROW | 09:30 | @owl             |                |
| LAX      | SUNDAY   | 21:30 | @piglet          |                |
| FRA      | MONDAY   | 23:00 | @tigger          |                |
| HND      | TUESDAY  | 16:00 |                  |                |
| MEL      | WEDNESDAY| 10:30 |                  |                |
| PAR      | THURSDAY | 03:00 | @christopher     |                |
| GIG      | FRIDAY   | 15:00 | @eeyore          |                |
| TLL      | SATURDAY | 22:30 | @rabbit          |                |
|----------|----------|-------|------------------|----------------|
```

Running:
```
./bin/gen-deployment-calendar.rb 2.11.3 1-mar-2019
```

Creates a file named `2_11_3.md` containing:

```
|----------|----------|-------|------------------|----------------|
| Instance | Date     | Time  | Who              | Duration (min) |
|----------|----------|-------|------------------|----------------|
| STAGING  |  30-Mar  | 09:00 | @owl             |                |
| PREPROD  |  31-Mar  | 09:30 | @owl             |                |
| LAX      |  03-Mar  | 21:30 | @piglet          |                |
| FRA      |  04-Mar  | 23:00 | @tigger          |                |
| HND      |  05-Mar  | 16:00 |                  |                |
| MEL      |  06-Mar  | 10:30 |                  |                |
| PAR      |  07-Mar  | 03:00 | @christopher     |                |
| GIG      |  01-Mar  | 15:00 | @eeyore          |                |
| TLL      |  02-Mar  | 22:30 | @rabbit          |                |
|----------|----------|-------|------------------|----------------|
```
