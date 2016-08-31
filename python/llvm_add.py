from ctypes import CFUNCTYPE, c_int32

import llvmlite.ir as ir
import llvmlite.binding as binding

binding.initialize()
binding.initialize_native_target()
binding.initialize_native_asmprinter()

def make_add_fn():
    global ee
    int32 = llvm.ir.IntType(32)

    module = ir.Module()
    adder_type = ir.FunctionType(int32, (int32, int32))
    adder = ir.Function(module, adder_type, 'add')
    adder.args[0].name = 'a'
    adder.args[1].name = 'b'

    bb_entry = adder.append_basic_block('entry')
    irbuilder = ir.IRBuilder(bb_entry)
    s = irbuilder.add(adder.args[0], adder.args[1])
    irbuilder.ret(s)

    llvm_module = binding.parse_assembly(str(module))
    tm = binding.Target.from_default_triple().create_target_machine()

    ee = binding.create_mcjit_compiler(llvm_module, tm)
    ee.finalize_object()

    cfptr = ee.get_function_address('add')

    cfunc = CFUNCTYPE(c_int32, c_int32, c_int32)(cfptr)

    print(cfunc(3, 4))
    return cfunc
