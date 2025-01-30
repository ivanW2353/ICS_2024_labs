#include "common.h"
#include "memory.h"

namespace virtual_machine_nsp
{
    void memory_tp::ReadMemoryFromFile(std::string filename, int beginning_address)
    {
        // Read from the file
        // TO BE DONE
        std::ifstream input_file;
        input_file.open(filename);
        if (input_file.is_open())
        {
            std::string line;
            int address = beginning_address;
            while (std::getline(input_file, line))
            {
                memory[address] = TranslateInstruction(line);
                address++;
            }
        }
    }

    int16_t memory_tp::GetContent(int address) const
    {
        // get the content
        // TO BE DONE
        return memory[address];
    }

    int16_t &memory_tp::operator[](int address)
    {
        // get the content
        // TO BE DONE
        return memory[address];
    }
}; // virtual machine namespace
