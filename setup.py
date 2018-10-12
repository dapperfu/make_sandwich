import versioneer
import sys

version=versioneer.get_version()
cmdclass=versioneer.get_cmdclass()

try:
    if sys.argv[1]=="--version":
        print(version)
    exit(code=0)
except IndexError:
    exit(code=1)
except:
    exit(code=2)
finally:
    exit(code=3)
