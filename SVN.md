SVN是什么？
    SVN是开源的版本控制系统。
    比CVS更多的特性。一个更好的CVS？因此SVN具有大部分CVS拥有的特性。
    不仅仅是文件受控，目录也加入版本控制。
    复制，删除，重命名这些操作都是受控的。
    特殊作用的元数据（属性）。
    提交事务原子性。提交完成之前任何一个部分都不会正真生效。版本号基于提交，而不是基于文件。提交时的log message也是依附于提交的那个版本。
    创建分支和标记非常简单。简单的通过copy命令就可以创建分支和标记。
    合并跟踪。在合并时协助你处理所有的更改点。
    文件锁定。svn支持文件锁定修改策略。
    Unix的link可以受控了。前提是WC必须在Unix下。
    可选的Apache network server，基于WEBDAV/DeltaV 协议。熟悉Apache的管理员会很喜欢这一点。
    内置的server选择（svnserve）。如果不想用Apache，可以试试Svn自己的server：svnserve。同样也能提供授权和验证，ssh通道等功能。
    方便解析的输出。svn的输出尽量做到方便阅读和方便机器解析。
    冲突解决交互性良好。svn命令行客户端提供多种不同的方式解决冲突。
    svn提供一个实用工具，svnsync来实现从主库到只读附属库的同步。
    持续写入代理功能让只读的附属库专门处理所有的读请求。所有的写请求交给主库处理。这个功能只在使用Apache WebDAV server的时候才有效。
    基于本地化的客户机服务器体系，分层的库，明晰的API方便扩展。
    高效处理二进制文件。
    性能消耗与更改点的数量成正比。
    svn的api可以和多种语言集成。Python，Perl,Java,Ruby（svn本身是用C写的）
    ChangeLists功能。
    Svn的安装分客户端和服务端。


以下是svn客户端常用命令一览：
    svn add [path]
    别名：无
    描述：添加文件或目录到你的wc，打上新增标记。这些文件会在下一次你提交wc的时候提交到svn服务器。
    在提交前，你也可以用svn revert撤销新增的文件。
    访问库：否
    eg: svn add file.cpp


svn blame Target[@REV]
    别名：praise,annotate,ann
    描述：显示某个已受控文件的每一行的最后修改版本和作者
    访问库：
    eg: svn blame file.cpp
    eg: svn blame --xml file.cpp  ##加上xml参数可以以xml格式显示每一行的属性。


svn cat TARGET[@REV]
    别名：无
    描述：输出指定目标的内容，这里的目标一般是文件。
    访问库：是
    eg:svn cat file.cpp
    eg:svn cat file.cpp -r 2 ##显示版本号为二的file.cpp内容。
    eg:svn cat file.cpp --revision HEAD ##显示最新版本的file.cpp内容。


svn changelist CLNAME TARGET...
svn changelist --remove TARGET
    别名：cl
    描述：可以将wc中的文件从逻辑上分组.
    访问库：否
    eg:svn cl clName file.cpp file2.cpp file3.cpp  ##将file.cpp等三个文件加入名叫clName的changelist
    eg:svn commit --changelist clName -m "ci"  ##将clName下的所有文件提交


svn checkout URL[@REV]... [PATH]
    别名：co
    描述：检出
    访问库：否
    eg:svn checkout file:///var/svn/repos/test  file:///var/svn/repos/quiz working-copies
    eg:svn checkout -r 2 file:///var/svn/repos/test mine  ##check out 版本号为2的项目

svn cleanup [PATH...]
    别名：无
    描述：递归的清理WC中过期的锁和未完成的操作。
    访问库：否
    eg：svn cleanup


svn commit [PATH...]
    别名：ci
    描述：把你WC的更改提交到仓库
    访问库：是
    eg：svn commit -m "added howto section." ##默认情况下提交必须提供log message


svn copy SRC[@REV]... DST
    别名：cp
    描述:copy操作可以从WC到WC；WC到URL；URL到WC；URL到URL。现在SVN只支持同一个仓库内文件的拷贝，不允许跨仓库操作。
    访问库：是
    eg：svn copy -r 11 file:///var/svn/repos/test/trunk \
               file:///var/svn/repos/test/tags/0.6.32-prerelease \
               -m "Forgot to tag at rev 11"
    ##copy命令是创建分支和标记的常用方式。copy到url的操作隐含了提交动作，所以需要提供log messages。

 

svn delete PATH...
    别名：del，remove，rm
    描述：删除
    访问库：如果PATH是库地址时会，删除WC内的文件不会。
    eg：svn del localfile.cpp    ##删除WC里的文件，在下一次提交WC的时候才会真正在仓库里将对应文件删除。
    eg: svn del file:///var/svn/repos/test/yourfile  ##删除仓库里的文件


svn diff
    别名：di
    描述：用来比较并显示修改点。
    访问库：
    eg：svn diff   ##最常用的方式，用来显示WC基于最近一次更新以后的所有的本地修改点。
    eg：svn diff -r 301 bin ## 比较WC和版本301中的bin目录的修改点
    eg：svn diff -r 3000:3500 file:///var/svn/repos/myProject/trunk   ##比较库里主干3000版和3500版的差异。
    eg：svn diff --summarize --xml http://svn.red-bean.com/repos/test@r2 http://svn.red-bean.com/repos/test  ##--summarize --xml 参数将差异情况以xml文档的方式显示出来。


svn export [-r REV] URL[@PEGREV] [PATH]
svn export [-r REV] PATH1[@PEGREV] [PATH2]
    别名：无
    描述：导出一个干净的目录树，不包含所有的受控信息。可以选择从URL或WC中导出。
    访问库：如果访问的是URL则会。
    eg：svn export file:///var/svn/repos my-export   ##导出到my-export目录。


svn help — Help!
    别名：?,h
    描述：不用解释了
    访问库：否。

 

svn import [PATH] URL
    别名：无
    描述：导入本地一个目录到库中。但是导入后，本地的目录并不会处于受控状态。
    访问库：是。
    eg：svn import -m "New import" myproj http://svn.myProject.com/repos/trunk/misc


svn info [TARGET[@REV]...]
    别名：无
    描述：显示指定WC和URL信息。
    访问库：仅当访问的是库路径时。
    eg：svn info --xml http://svn.myProject.com/repos/test  ##将信息以xml格式显示。


svn list [TARGET[@REV]...]
    别名：ls
    描述：显示目标下的文件和目录列表。
    访问库：如果访问的是库地址就会。
    eg：svn list --verbose file:///var/svn/repos   ##--verbose参数表示显示详细信息。


svn lock TARGET...
    别名：无
    描述：对目标获得修改锁。如果目标已被其他用户锁定，则会抛出警告信息。用--force参数强制从其他用户那里获得锁。
    访问库：是
    eg：svn lock --force tree.jpg
 

svn log [PATH]
svn log URL[@REV] [PATH...]
    别名：无
    描述：从库中显示log消息。log消息代码 A ：added  D：deleted  M：modified  R：replaced
    访问库：是
    eg：svn log -v http://svn.myProject.com/repos/test/ foo.c bar.c   ##详细显示指定URL的库中foo.c和bar.c所有版本的log信息。
    eg：svn log -r 14:15    ##显示当前WC的14和15版本log信息。
    eg：##如果版本号不连续，只能采用如下方式。
    $ svn log -r 14 > mylog
    $ svn log -r 19 >> mylog
    $ svn log -r 27 >> mylog
     

svn merge sourceURL1[@N] sourceURL2[@M] [WCPATH]
svn merge sourceWCPATH1@N sourceWCPATH2@M [WCPATH]
svn merge [[-c M]... | [-r N:M]...] [SOURCE[@REV] [WCPATH]]
    别名：无
    描述：合并两个受控源的不同之处，存放到一个WC里。
    访问库：只有当访问库地址时。
    eg：svn merge --reintegrate http://svn.example.com/repos/calc/branches/my-calc-branch  ##合并分支上的改变项到WC，往往用于分支合并到主干。
    eg：svn merge -r 156:157 http://svn.example.com/repos/calc/branches/my-calc-branch   ##将制定URL版本156到157的所有更新合并到WC。

 

svn mkdir PATH...
svn mkdir URL...
    别名：无
    描述：在WC或库路径创建目录
    访问库：只有当访问库地址时。
    eg：svn mkdir newdir
     

svn move SRC... DST
    别名：mv, rename, ren
    描述：等同于svn copy命令跟个svn delete命令。WC到URL的重命名是不被允许的。
    访问库：只有当访问库地址时。
    eg：svn move foo.c bar.c  ##将foo.c改名成bar.c。

 

svn propdel PROPNAME [PATH...]
svn propdel PROPNAME --revprop -r REV [TARGET]
    别名：pdel, pd
    描述：从受控文件，目录等删除属性。第二种是删除某个指定版本上的附加属性。
    访问库：只有当访问库地址时。
    eg：svn propdel svn:mime-type someFile    ##从someFile上移除svn:mime-type这个属性。

 

svn propedit PROPNAME TARGET...
svn propedit PROPNAME --revprop -r REV [TARGET]
    别名：pedit, pe
    描述：编辑属性
    访问库：只有当访问库地址时。
    eg：svn propedit svn:keywords  file.c  ##修改file.c上的svn:keywords属性。

 

svn propget PROPNAME [TARGET[@REV]...]
svn propget PROPNAME --revprop -r REV [URL]
    别名：pget,pg
    描述：从文件，目录或版本取得指定属性的值。
    访问库：只有当访问库地址时。
    eg：svn propget svn:keywords file.c   ##从file.c中取得svn:keywords属性的值

 

svn proplist [TARGET[@REV]...]
svn proplist --revprop -r REV [TARGET]
    别名：plist, pl
    描述：列出文件、目录或版本上的所有附加属性
    访问库：只有当访问库地址时。
    eg：svn proplist --verbose file.c

 

svn propset PROPNAME [PROPVAL | -F VALFILE] PATH...
svn propset PROPNAME --revprop -r REV [PROPVAL | -F VALFILE] [TARGET]
    别名：pset,ps
    描述：给文件、目录或版本附加属性并赋值
    访问库：只有当访问库地址时。
    eg：svn propset svn:mime-type image/jpeg file.jpg   ##给file.jpg附加属性svn:mime-type 其值为image/jpeg
    eg:svn propset --revprop -r 25 svn:log "Journaled about trip to New York."

##给版本25补上log message

eg:svn propset svn:ignore '.classpath' . 

##在本地忽略掉.classpath文件

 

svn resolve PATH...
    别名：无
    描述：将冲突的文件标记为已解决，并且删掉冲突产生的临时文件。注意这个命令并不是能把冲突解决，解决冲突还是得靠人工。
    访问库：否
    eg：svn resolve --accept mine-full foo.c   ##1.5版本后，加上--accept参数，尝试自动处理冲突。
    
     

svn resolved PATH...
    别名：无
    描述：已过时，被resolve --accept取代。去除冲突的状态和冲突临时文件。
    访问库：否

 

svn revert PATH...
    别名：无
    描述：还原WC中所有的本地更改。
    访问库：否
    eg：svn revert --depth=infinity .   ##将整个目录所有文件还原

 

svn status [PATH...]
    别名：stat, st
    描述：输出WC中文件和目录的状态。如果WC提交，这些状态就会同步到库里。
    一般状态有         ' '  没有修改
    'A'  新增
    'D'  删除
    'M'  修改
    'R'  替代
    'C'  冲突
    'I'  忽略
    '?'  未受控
    '!'  丢失，一般是将受控文件直接删除导致
    访问库：加上--show-updates参数时会
    eg：svn status wc

 

svn switch URL[@PEGREV] [PATH]
svn switch --relocate FROM TO [PATH...]
    别名：sw
    描述：将WC转向一个其他的库地址同步
    访问库：是
    eg：svn sw http://svn.myProject.com/repos/trunk/vendors .  ##将当前WC切换到另一个URL

 

svn unlock TARGET...
    别名：无
    描述：解锁
    访问库：是
    eg：svn unlock somefile

 

svn update [PATH...]
    别名：up
    描述：更新WC，更新反馈有如下几种分类。
        A  新增
        B  锁破坏
        D  删除
        U  更新
        C  冲突
        G  合并
        E  存在的
    访问库：是
    eg：svn up -r22   ##更新到一个指定版本





常用命令
 

1、帮助命令： help(h)

命令使用：svn help
命令简写：svn h
命令解释：使用这个命令可以看到关于svn所有命令以及简写。有时候有那个命令忘了，可以看看，很有用。
2、往版本库中添加新文件：add

命令使用：svn add xxx.txt
命令解释：这个命令使用之后，还得使用svn ci xxx.txt命令提交一下。
举例：svn add *.php（添加当前目录下的所有php文件）
3、将改变的文件提交到版本库：commit(ci)

命令使用：svn commit -m "LogMessage" xxx.txt
命令简写：svn ci -m "LogMessage" xxx.txt
4、检出文件到本地：checkout

命令使用：svn checkout path(项目库的路径)
命令简写：svn co path
5、更新版本：update(up)

命令使用：svn update -r m path
命令简写：svn up
命令解释：该命令使用频率应该是最高的。svn update后面如果没有目录或文件，默认将目录下的文件以及子目录都更新到最新版。 
-r：指定更新到哪个版本。举例：svn up -r 200 123.txt（将本地的123.txt文件还原到版本200）
6、查看日志：log

命令使用：svn log xxx.txt
命令解释：用来显示这个文件的修改记录，以及修改者对修改的描述。
7、查看文件详细信息：info

命令使用：svn info xxx.txt
命令解释：这个命令会展示当前文件的路径、名称、版本号、类型等信息。
8、比较差异：diff(di)

命令使用：svn diff -r m:n xxx.txt
命令简写：svn di -r m:n xxx.txt
命令解释：对版本m和版本n比较差异。 
-r：需要对比的两个版本号。举例：svn di -r 2:3 123.txt（查看123.txt的2版本和3版本之间的差异）。
9、删除文件：delete(del,remove,rm)

命令使用：svn delete path -m "DeleteMessage"
命令简写：svn del/remove/rm path -m "DeleteMessage"
命令解释：使用这个命令有两种方式。 
远程删除：svn delete svn://192.168.1.1/project_v1/123.php -m "delete test file"（使用这种方式删除后，直接会删除掉版本库中的文件）。
提交删除：首先svn delete 123.php，然后svn ci -m "delete file"（推荐使用这种方式）。
 

 

2、不常用命令
 

10、对文件加锁：lock

命令使用：svn lock -m "LockMessage" xxx.txt
命令解释：主要是防止文件冲突。
11、对文件解锁：unlock

命令使用：svn unlock xxx.txt
12、移动文件或者文件更名：move(mv,rename,ren)

命令使用：svn move -m "MoveMessage" xxx.txt
命令简写：svn mv/rename/ren -m "MoveMessage" xxx.txt
命令解释：我们来举两个例子，更直观理解这个命令。 
svn move -m "rename file" 123.txt 456.txt（将当前目录下的123.txt更名为456.txt）。
svn move -m "move file" 123.txt test/123.txt（将当前目录下的123.txt移动到当前子目录test下去）。
13、列出属于版本库下的文件和目录：list(ls)

命令使用：svn list path
命令简写：svn ls
命令解释：显示path目录下的所属于版本库的文件和目录。如果没有path参数，显示当前目录下的所属于版本库的文件和目录。
 

 

3、Linux SVN 命令详解
 

1、将文件 checkout 到本地目录

        svn checkout path（path是服务器上的目录）
        例如：svn checkout svn://192.168.1.1/pro/domain
        简写：svn co

2、往版本库中添加新的文件

        svn add file
        例如：svn add test.php(添加test.php)
        svn add *.php(添加当前目录下所有的php文件)

3、将改动的文件提交到版本库

        svn commit -m "LogMessage" [-N] [--no-unlock] PATH(如果选择了保持锁，就使用--no-unlock开关)
        例如：svn commit -m "add test file for my test" test.php
        简写：svn ci

4、加锁/解锁

        svn lock -m "LockMessage" [--force] PATH
        例如：svn lock -m "lock test file" test.php
        svn unlock PATH

5、更新到某个版本

        svn update -r m path
        例如：
        svn update如果后面没有目录，默认将当前目录以及子目录下的所有文件都更新到最新版本。
        svn update -r 200 test.php(将版本库中的文件test.php还原到版本200)
        svn update test.php(更新，于版本库同步。如果在提交的时候提示过期的话，是因为冲突，需要先update，修改文件，然后清除svn resolved，最后再提交commit)
        简写：svn up

6、查看文件或者目录状态

        1）svn status path（目录下的文件和子目录的状态，正常状态不显示）
            【?：不在svn的控制中；M：内容被修改；C：发生冲突；A：预定加入到版本库；K：被锁定】
        2）svn status -v path(显示文件和子目录状态)
            第一列保持相同，第二列显示工作版本号，第三和第四列显示最后一次修改的版本号和修改人。
        注：svn status、svn diff和 svn revert这三条命令在没有网络的情况下也可以执行的，原因是svn在本地的.svn中保留了本地版本的原始拷贝。
        简写：svn st

7、删除文件

        svn delete path -m "delete test fle"
        例如：svn delete svn://192.168.1.1/pro/domain/test.php -m "delete test file"
        或者直接svn delete test.php 然后再svn ci -m 'delete test file‘，推荐使用这种
        简写：svn (del, remove, rm)

8、查看日志

        svn log path
        例如：svn log test.php 显示这个文件的所有修改记录，及其版本号的变化

9、查看文件详细信息

        svn info path
        例如：svn info test.php

10、比较差异

        svn diff path(将修改的文件与基础版本比较)
        例如：svn diff test.php
        svn diff -r m:n path(对版本m和版本n比较差异)
        例如：svn diff -r 200:201 test.php
        简写：svn di

11、将两个版本之间的差异合并到当前文件

        svn merge -r m:n path
        例如：svn merge -r 200:205 test.php（将版本200与205之间的差异合并到当前文件，但是一般都会产生冲突，需要处理）

12、SVN 帮助

        svn help
        svn help ci

------------------------------------------------------------------------------

以上是常用命令，下面写几个不经常用的

------------------------------------------------------------------------------

13、版本库下的文件和目录列表

        svn list path
        显示path目录下的所有属于版本库的文件和目录
        简写：svn ls

 

14、创建纳入版本控制下的新目录

        svn mkdir: 创建纳入版本控制下的新目录。
        用法: 1、mkdir PATH...
                 2、mkdir URL...
        创建版本控制的目录。
        1、每一个以工作副本 PATH 指定的目录，都会创建在本地端，并且加入新增调度，以待下一次的提交。
        2、每个以URL指定的目录，都会透过立即提交于仓库中创建。
        在这两个情况下，所有的中间目录都必须事先存在。

 

15、恢复本地修改

        svn revert: 恢复原始未改变的工作副本文件 (恢复大部份的本地修改)。revert:
        用法: revert PATH...
        注意: 本子命令不会存取网络，并且会解除冲突的状况。但是它不会恢复被删除的目录

 

16、代码库URL变更

        svn switch (sw): 更新工作副本至不同的URL。
        用法: 1、switch URL [PATH]
                 2、switch --relocate FROM TO [PATH...]

        1、更新你的工作副本，映射到一个新的URL，其行为跟“svn update”很像，也会将服务器上文件与本地文件合并。这是将工作副本对应到同一仓库中某个分支或者标记的方法。
        2、改写工作副本的URL元数据，以反映单纯的URL上的改变。当仓库的根URL变动 (比如方案名或是主机名称变动)，但是工作副本仍旧对映到同一仓库的同一目录时使用这个命令更新工作副本与仓库的对应关系。

 

17、解决冲突

        svn resolved: 移除工作副本的目录或文件的“冲突”状态。
        用法: resolved PATH...
        注意: 本子命令不会依语法来解决冲突或是移除冲突标记；它只是移除冲突的相关文件，然后让 PATH 可以再次提交。

 

18、输出指定文件或URL的内容。

        svn cat 目标[@版本]...如果指定了版本，将从指定的版本开始查找。
        svn cat -r PREV filename > filename (PREV 是上一版本,也可以写具体版本号,这样输出结果是可以提交的)

 

19、 查找工作拷贝中的所有遗留的日志文件，删除进程中的锁 。

当Subversion改变你的工作拷贝（或是.svn 中 的任何信息），它会尽可能的小心，在修改任何事情之前，它把意图写到日志文件中去，然后执行log文件中的命令，然后删掉日志文件，这与分类帐的文件系统 架构类似。如果Subversion的操作中断了（举个例子：进程被杀死了，机器死掉了），日志文件会保存在硬盘上，通过重新执行日志文 件，Subversion可以完成上一次开始的操作，你的工作拷贝可以回到一致的状态。

这就是svn cleanup 所作的：它查找工作拷贝中的所有遗留的日志文件，删除进程中的锁。如果Subversion告诉你工作拷贝中的一部分已经“锁定 ”了，你就需要运行这个命令了。同样，svn status 将会使用L 显示锁定的项目：

$ svn status
L somedir
M somedir/foo.c

$ svn cleanup
$ svn status
M somedir/foo.c

 

20、 拷贝用户的一个未被版本化的目录树到版本库。
svn import 命令是拷贝用户的一个未被版本化的目录树到版本库最快的方法，如果需要，它也要建立一些中介文件。

$ svnadmin create /usr/local/svn/newrepos $ svn import mytree file:///usr/local/svn/newrepos/some/project Adding mytree/foo.c Adding mytree/bar.c Adding mytree/subdir Adding mytree/subdir/quux.h Committed revision 1.

