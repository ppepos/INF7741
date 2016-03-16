import opts
import asm
import disasm

var opts = new OptionContext

var opt_assemble = new OptionString("Assemble", "-a")
var opt_disasm = new OptionString("Disassemble", "-d")
var opt_help = new OptionBool("Show this help message", "-h", "--help")

opts.add_option(opt_assemble, opt_disasm, opt_help)
opts.parse args

if opts.errors.not_empty then
	for error in opts.errors do print error
	exit 1
else if opt_help.value then
	print "Usage: {program_name} [OPTION] filename\nOptions:"
	opts.usage
	exit 0
end

if opt_assemble.value != null then
	var fname = opt_assemble.value.to_s
	var model = new Pep8Model(fname)

	model.load_instruction_set("pep8.json")
	model.read_instructions

	for byte in model.assemble do stdout.write_byte byte
else if opt_disasm.value != null then
	var fname = opt_disasm.value.to_s
	var model = new Pep8Model(fname)

	model.load_instruction_set("pep8.json")
	model.read_instructions
end

