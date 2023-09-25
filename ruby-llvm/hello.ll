; ModuleID = 'hello_world'
source_filename = "hello"

@.str = private unnamed_addr constant [13 x i8] c"Hello World!\00"

declare i32 @puts(i8*)

define i32 @main() {
  %1 = call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}
