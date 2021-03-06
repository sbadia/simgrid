/*
 * OutOfBoundsException.hpp
 *
 * Copyright 2006,2007 Martin Quinson, Malek Cherier           
 * All right reserved. 
 *
 * This program is free software; you can redistribute 
 * it and/or modify it under the terms of the license 
 *(GNU LGPL) which comes with this package. 
 *
 */  
 
#ifndef MSG_OUTOFBOUNDSEXCEPTION_HPP
#define MSG_OUTOFBOUNDSEXCEPTION_HPP

#ifndef __cplusplus
	#error OutOfBoundsException.hpp requires C++ compilation (use a .cxx suffix)
#endif

#include <Exception.hpp>

namespace SimGrid
{
	namespace Msg
	{
		
		class SIMGRIDX_EXPORT OutOfBoundsException : public Exception
		{
			public:
			
			// Default constructor.
				OutOfBoundsException();
			
			// Copy constructor.
				OutOfBoundsException(const OutOfBoundsException& rOutOfBoundsException);
			
			// This constructor takes the position in the range.
				OutOfBoundsException(int pos);

				OutOfBoundsException(int pos1, int pos2);
			
			// Destructor.
				virtual ~OutOfBoundsException();
				
			// Operations.
					
					// Returns the reason of the exception :
					// the message "Out of bounds : `pos'"
					const char* toString(void) const;
			
			// Operators.
				
				// Assignement.
				const OutOfBoundsException& operator = (const OutOfBoundsException& rOutOfBoundsException);
				
			private :
			
			// Attributes.
				
				// A buffer used to build the message returned by the methode toString().
				char* reason;
		};
		
		
	} // namespace Msg	

}// namespace SimGrid


#endif // !MSG_MSGEXCEPTION_HPP

