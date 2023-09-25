# File: generate_llvm_ir_hello.rb

class LLVMIRHelloWorldGenerator
  def initialize
    @ir_code = ""
  end

  def generate
    add_header
    add_string
    add_declaration
    add_define
    add_body
    add_footer
  end

  def to_s
    @ir_code
  end

  private

  def add_header
    @ir_code << "; ModuleID = 'hello_world'\n"
    @ir_code << "source_filename = \"hello\"\n\n"
  end
  
  def add_string
    @ir_code << "@.str = private unnamed_addr constant [13 x i8] c\"Hello World!\\00\"\n\n"
  end

  def add_declaration
    @ir_code << "declare i32 @puts(i8*)\n\n"
  end

  def add_define
    @ir_code << "define i32 @main() {\n"
  end

  def add_body
    @ir_code << "  %1 = call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0))\n"
    @ir_code << "  ret i32 0\n"
  end

  def add_footer
    @ir_code << "}\n"
  end
end

generator = LLVMIRHelloWorldGenerator.new
generator.generate
# Write the generated code to a file
File.write('hello.ll', generator.to_s)

puts 'LLVM IR code written to hello.ll'
