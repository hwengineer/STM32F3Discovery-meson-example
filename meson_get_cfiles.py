
import argparse, os

# parser = argparse.ArgumentParser()
# parser.add_argument('--dir', help='foo help')
# args = parser.parse_args()


if __name__ == "__main__":

    out = []

    for dirname, dirnames, filenames in os.walk('/home/ottale/git/projekte/[996]_STM32_Libs/STM32Cube_FW_F3_V1.9.0/Drivers/STM32F3xx_HAL_Driver/Src'):
        # print path to all subdirectories first.
        for subdirname in dirnames:
            # print(os.path.join(dirname, subdirname))
            pass

        # print path to all filenames.
        for filename in filenames:
            out.append( os.path.join(dirname, filename) )

        # # Advanced usage:
        # # editing the 'dirnames' list will stop os.walk() from recursing into there.
        # if '.git' in dirnames:
        #     # don't go into any .git directories.
        #     dirnames.remove('.git')

    out.sort()

    for x in out:
        print(x)
