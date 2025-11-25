import subprocess

'''
opt_file = "cf_7.txt"
scasp_file = "test_2.pl"
scasp_path = './s(CASP)/'
'''

def run_sCASP_script(opt_file, scasp_file,scasp_path):
    """
    Runs an sCASP (Prolog-based) script using `scasp`. 
    Requires sCASP to be installed and accessible via `scasp`.
    """
    # Each part of the command should be in its own list element
    cmd = ["scasp", "--bind=" + scasp_path+opt_file, "-s0", scasp_path+scasp_file]
    
    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode == 0:
        print("Output:\n", result.stdout)
    else:
        print("Error:\n", result.stderr)