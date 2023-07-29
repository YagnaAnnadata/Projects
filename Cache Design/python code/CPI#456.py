import os
import shutil
import subprocess
import re

cache_size = [32,64]
L1_D_Associativity = [1,4]
L1_I_Associativity = [1,4]
L2_Associativity = [1,8]
L1_D_cache=[128,256]
L1_I_cache=[64,256]
L2_cache=[512,1024]

CPI_array = list()
i=0

os.chdir("/home/011/y/yx/yxa210024/spring23/comparc/project1/output/CPI")
CPI_path = "/home/011/y/yx/yxa210024/spring23/comparc/project1/output/CPI/CPI#456.txt"
minimum_CPI_path = "/home/011/y/yx/yxa210024/spring23/comparc/project1/output/CPI/minimum_CPI#456.txt"
CPI_Sorted_path = "/home/011/y/yx/yxa210024/spring23/comparc/project1/output/CPI/sorted_CPI#456.txt"
if os.path.exists(CPI_path):
	os.remove(CPI_path)
if os.path.exists(minimum_CPI_path):
	os.remove(minimum_CPI_path)
if os.path.exists(CPI_Sorted_path):
	os.remove(CPI_Sorted_path)
os.system("touch CPI#456.txt")
os.system("touch sorted_CPI#456.txt")
os.system("touch minimum_CPI#456.txt")
for size in cache_size:
	for L1_D_Assoc in L1_D_Associativity:
		for L1_I_Assoc in L1_I_Associativity:
			for L2_Assoc in L2_Associativity:
				for L1_D in L1_D_cache:
					for L1_I in L1_I_cache:
						for L2 in L2_cache:
							os.chdir("/home/011/y/yx/yxa210024/spring23/comparc/project1/output/456/")
							dirname ="456#"+str(size)+"-"+str(L1_D_Assoc)+"-"+str(L1_I_Assoc)+"-"+str(L2_Assoc)+"-"+str(L1_D)+"-"+str(L1_I)+"-"+str(L2)
							os.chdir(dirname)
							command1 = "grep 'system.cpu.dcache.overall_miss_rate::total     [0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]' stats.txt | grep -Eo '[0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]'"
							output1 = subprocess.check_output(command1, shell=True)
							L1D_missRate = output1.decode().strip()
							command2 = "grep 'system.cpu.icache.overall_miss_rate::total     [0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]' stats.txt | grep -Eo '[0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]'"
							output2 = subprocess.check_output(command2, shell=True)
							L1I_missRate = output2.decode().strip()
                            				command3 = "grep 'system.l2.overall_miss_rate::total           [0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]' stats.txt | grep -Eo '[0-9]*\.[0-9][0-9][0-9][0-9][0-9][0-9]'"
							output3 = subprocess.check_output(command3, shell=True)
							L2_missRate = output3.decode().strip()
							command4 = "grep 'system.cpu.dcache.overall_misses::total         [0-9]*' stats.txt | grep -Eo '[0-9]*'"
							output4 = subprocess.check_output(command4, shell=True)
							L1D_misses = output4.decode().strip()
							command5 = "grep 'system.cpu.icache.overall_misses::total         [0-9]*' stats.txt | grep -Eo '[0-9]*'"
							output5 = subprocess.check_output(command5, shell=True)
							L1I_misses = output5.decode().strip()
							command6 = "grep 'system.l2.overall_misses::total                 [0-9]*' stats.txt | grep -Eo '[0-9]*'"
							output6 = subprocess.check_output(command6, shell=True)
							L2_misses = output6.decode().strip()
							L2_misses = re.sub(r'\D', '', L2_misses)

							L1D_missRate=float(L1D_missRate)
							L1I_missRate=float(L1I_missRate)
							L2_missRate=float(L2_missRate)
							
							L1D_misses = L1D_misses.replace(" ", "")
							L1I_misses = L1I_misses.replace(" ", "")

							L2_misses = L2_misses.replace(' ', '')
							L1D_misses=float(L1D_misses)
							L1I_misses=float(L1I_misses)
							L2_misses=float(L2_misses)
							
							L1D_missRate=L1D_missRate*100
                            				L1I_missRate=L1D_missRate*100
                            				L2_missRate=L1D_missRate*100

							L1D_missRate_str=str(L1D_missRate)
							L1I_missRate_str=str(L1I_missRate)
							L2_missRate_str=str(L2_missRate)

							L1D_miss_str=str(L1D_misses)
							L1I_miss_str=str(L1I_misses)
							L2_miss_str=str(L2_misses)


							
                            				CPI = 1+((((L1D_misses+L1I_misses)*6)+(L2_misses*50))/(75000000))
							calculated_CPI=str(CPI)


							i +=1
							intt =str(i)
							with open(CPI_path, 'a') as file:
								file.write(intt+'\t\t')
								file.write(dirname+'\t\t')
								file.write(L1D_miss_str+'\t')
								file.write(L1I_miss_str+'\t')
								file.write(L2_miss_str+'\t')
								file.write(L1D_missRate_str+'\t')
								file.write(L1I_missRate_str+'\t')
								file.write(L2_missRate_str+'\t')
								file.write(calculated_CPI+'\n')

							CPI_end_string= intt+"#"+dirname+"#"+L1D_miss_str+"#"+L1I_miss_str+"#"+L2_miss_str+"#"+L1D_missRate_str+"#"+L1I_missRate_str+"#"+L2_missRate_str+"#"
							tmp ={CPI:CPI_end_string}
                            				CPI_array.append(tmp)
                            				CPI_array.sort()
                            				if CPI_array[0].keys()[0] ==CPI:
								if os.path.exists(minimum_CPI_path):
									os.remove(minimum_CPI_path)
                                					with open(minimum_CPI_path, 'a') as file:
										file.write(intt+'\t\t')
										file.write(dirname+'\t\t')
										file.write(L1D_miss_str+'\t')
										file.write(L1I_miss_str+'\t')
										file.write(L2_miss_str+'\t')
										file.write(L1D_missRate_str+'\t')
										file.write(L1I_missRate_str+'\t')
										file.write(L2_missRate_str+'\t')
										file.write(calculated_CPI+'\n')

with open(CPI_Sorted_path, 'a') as file:
	for cpi in CPI_array:
		file.write(str(cpi) + "\n")

