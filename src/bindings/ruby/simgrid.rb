# FIXME: add license like in C files

require 'simgrid_ruby'
require 'thread'

$DEBUG = false  # This is a Global Variable Useful for MSG::debugging

###########################################################################
# Class Semaphore 
###########################################################################
class MySemaphore
   Thread.abort_on_exception = true
    attr_accessor :permits

   
  def initialize (permits = 0)
       @permits = permits
  end
  
  def acquire(mutex,cv)

    raise "Interrupted Thread " if (!Thread.current.alive?)
    mutex.synchronize {
    while @permits <= 0
       
       cv.wait(mutex)
       
    end
    @permits = @permits - 1
    cv.signal
    }
    
  end
    
  def release(mutex,cv)
    mutex.synchronize{
      @permits += 1
      cv.signal
      }
  end  
end
#######################################
# Another Semaphore
#######################################

class Semaphore
  def initialize(initvalue = 0)
    @counter = initvalue
    @waiting_list = []
  end

  def acquire
    MSG::debug("Acquire "+self.to_s)
    Thread.critical = true
    if (@counter -= 1) < 0
      @waiting_list.push(Thread.current)
      Thread.stop
    end
    self
  ensure
    Thread.critical = false
  end

  def release
    MSG::debug("Release "+self.to_s)
    Thread.critical = true
    begin
      if (@counter += 1) <= 0
        t = @waiting_list.shift
        t.wakeup if t
        MSG::debug("Wakeup "+t.to_s)
      else 
        MSG::debug("Nobody to wakeup")
      end
    rescue ThreadError
      retry
    end
    self
  ensure
    Thread.critical = false
  end
end

########################################################################
# Class Process 
########################################################################
class MSG::Process < Thread 
  @@nextProcessId = 0

# Attributes
  attr_reader :bind, :id, :name, :pargs ,:properties# Read only
  
    def initialize(*args)
      super(){
	
     raise "Bad Number Of arguments to create a Ruby Process (name,args,prop) " if args.size < 3
     
#     @cv = ConditionVariable.new
#     @mutex = Mutex.new
    @schedBegin = Semaphore.new(0)
    @schedEnd = Semaphore.new(0)    
    @id = @@nextProcessId
    @@nextProcessId +=1
    @name = args[0]
    @pargs = args[1]
    @properties = args[2]
      
    start()
      }
    end
    
  # main
  def main(args) 
    # To be overriden by childs
    raise("You must define a main() function in your process, containing the code of this process")
  end
     
  # Start : To keep the process alive and waiting via semaphore
  def start()
    @schedBegin.acquire()
    # execute the main code of the process     
    MSG::debug("Begin execution")
    main(@pargs)
#     processExit(self) # Exit the Native Process
    @schedEnd.release()
  end
    

  # FIXME: useless, there is an attribute for bind (or the attribute is useless)
  # Get Bind
  def getBind()
    return @bind
  end
  
  # Set Binds FIXME: same
  def setBind(bind)
    @bind = bind
  end
    
  def unschedule()
    @schedEnd.release()
    @schedBegin.acquire()
  end
  
  def schedule()
    @schedBegin.release()
    @schedEnd.acquire()
  end
  
  def pause()
    processSuspend(self)
  end
  
  def restart()
    processResume(self)
  end
  
  def isSuspended()
    processIsSuspended(self)
  end
  
  def getHost()
    processGetHost(self)
  end
  
# The Rest of Methods !!! To be Continued ... FIXME: what's missing?
end

############################################
# Task Extend from the native Class RbTask
############################################
class MSG::Task < MSG::RbTask

  def initialize(*args)
     super()
  end
  
  def name
     super(self)
  end
  
  def compSize
     super(self)
  end
  
  def send(mailbox)
    super(self,mailbox)
  end
  
#   FIXME : this methode should be associated to the class !! it reurn a task
  def receive(mailbox)
    super(self,mailbox)
  end
  
  def source
    super(self)
  end
  
  def sender
    super(self)
  end
  
  def listen(t_alias)
    super(t_alias)
  end
  
  def execute
    super(self)
  end
    
  def listenFromHost(t_alias,host)
    super(t_alias,host)
  end
    
end  

############################################
# Host Extend from the native Class RbHost
############################################
class MSG::Host < MSG::RbHost

  def getByName(name)
    super(name)
  end
  
  def name
    super(self)
  end
  
  def speed
    super(self)
  end
  
  def getData
    super(self)
  end
  
  def setData(data)
    super(self,data)
  end
  
  def isAvail
    super(self)
  end
  
  def number
    super()
  end
  
end

#########################
# Main chunck 
#########################
MSG.init(ARGV)