# -*- coding: utf-8 -*-

##########################################################################################
# Copyright © 2013 Rodrigo Botafogo. All Rights Reserved. Permission to use, copy, modify, 
# and distribute this software and its documentation for educational, research, and 
# not-for-profit purposes, without fee and without a signed licensing agreement, is hereby 
# granted, provided that the above copyright notice, this paragraph and the following two 
# paragraphs appear in all copies, modifications, and distributions. Contact Rodrigo
# Botafogo - rodrigo.a.botafogo@gmail.com for commercial licensing opportunities.
#
# IN NO EVENT SHALL RODRIGO BOTAFOGO BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT, SPECIAL, 
# INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF 
# THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF RODRIGO BOTAFOGO HAS BEEN ADVISED OF THE 
# POSSIBILITY OF SUCH DAMAGE.
#
# RODRIGO BOTAFOGO SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE 
# SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED HEREUNDER IS PROVIDED "AS IS". 
# RODRIGO BOTAFOGO HAS NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, 
# OR MODIFICATIONS.
##########################################################################################

# require 'jruby/core_ext'

require 'java'

##########################################################################################
#
##########################################################################################

class Colt

  ########################################################################################
  #
  ########################################################################################

  module MatrixFloatingAlgebra

    #------------------------------------------------------------------------------------
    # Create a new Array using same backing store as this Array, by flipping the index 
    # so that it runs from shape[index]-1 to 0.
    #------------------------------------------------------------------------------------
    
    def flip(dim)
      MDMatrix.from_mdarray(@mdarray.flip(dim))
    end

    #------------------------------------------------------------------------------------
    # Computes the Kronecker product of two real matrices.
    #------------------------------------------------------------------------------------
    
    def kron(matrix)
      
      if (matrix.rank != 2)
        raise "Rank should be 2"
      end
      result = @colt_algebra.kron(@colt_matrix, matrix.colt_matrix)
      MDMatrix.from_colt_matrix(result)
      
    end

    #------------------------------------------------------------------------------------
    # Multiplies this matrix by another matrix
    #------------------------------------------------------------------------------------
    
    def mult(matrix)
      
      if (matrix.rank > 2)
        raise "Rank should be 1 or 2"
      end
      
      result = @colt_matrix.like
      @colt_matrix.zMult(matrix.colt_matrix, result)
      MDMatrix.from_colt_matrix(result)
      
    end
    
    alias :* :mult

    #------------------------------------------------------------------------------------
    # Returns the one-norm of vector x, which is Sum(abs(x[i])).
    #------------------------------------------------------------------------------------
    
    def norm1
      @colt_algebra.norm1(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the two-norm of matrix A, which is the maximum singular value; obtained 
    # from SVD.
    #------------------------------------------------------------------------------------
    
    def norm2
      @colt_algebra.norm2(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the Frobenius norm of matrix A, which is Sqrt(Sum(A[i,j]^2))
    #------------------------------------------------------------------------------------
    
    def normF
      @colt_algebra.normF(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the infinity norm of matrix A, which is the maximum absolute row sum.
    #------------------------------------------------------------------------------------
    
    def norm_infinity
      @colt_algebra.normInfinity(@colt_matrix)
    end

    #------------------------------------------------------------------------------------
    # Makes a view of this array based on the given parameters
    # shape
    # origin
    # size
    # stride
    # range
    # section
    # spec
    #------------------------------------------------------------------------------------
    
    def region(*args)
      MDMatrix.from_mdarray(@mdarray.region(*args))
    end

  end # MatrixFloatingAlgebra


  ########################################################################################
  #
  ########################################################################################

  module Matrix2DFloatingAlgebra
    include_package "cern.colt.matrix.tdouble.algo"
    include_package "cern.colt.matrix.tfloat.algo"
    
    #------------------------------------------------------------------------------------
    # Solves the upper triangular system U*x=b;
    #------------------------------------------------------------------------------------
    
    def backward_solve(matrix1D)
      result = @colt_algebra.backwardSolve(@colt_matrix, matrix1D.colt_matrix)
      MDMatrix.from_colt_matrix(result)
    end
    
    #------------------------------------------------------------------------------------
    # Constructs and returns the cholesky-decomposition of the given matrix. For a 
    # symmetric, positive definite matrix A, the Cholesky decomposition is a lower 
    # triangular matrix L so that A = L*L'; If the matrix is not symmetric positive 
    # definite, the IllegalArgumentException is thrown.
    #------------------------------------------------------------------------------------
    
    def chol
      result = @colt_algebra.chol(@colt_matrix).getL()
      MDMatrix.from_colt_matrix(result)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the condition of matrix A, which is the ratio of largest to smallest 
    # singular value.
    #------------------------------------------------------------------------------------
    
    def cond
      @colt_algebra.cond(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the determinant of matrix A.
    #------------------------------------------------------------------------------------
    
    def det
      @colt_algebra.det(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    #
    #------------------------------------------------------------------------------------
    
    def eig
      eig = @colt_algebra.eig(@colt_matrix)
      [MDMatrix.from_colt_matrix(eig.getD), 
       MDMatrix.from_colt_matrix(eig.getImagEigenvalues),
       MDMatrix.from_colt_matrix(eig.getRealEigenvalues),
       MDMatrix.from_colt_matrix(eig.getV)]
    end
        
    #------------------------------------------------------------------------------------
    # Solves the lower triangular system L*x=b;
    #------------------------------------------------------------------------------------
    
    def forward_solve(matrix1D)
      result = @colt_algebra.forwardSolve(@colt_matrix, matrix1D.colt_matrix)
      MDMatrix.from_colt_matrix(result)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the inverse or pseudo-inverse of matrix A.
    #------------------------------------------------------------------------------------
    
    def inverse
      result = @colt_algebra.inverse(@colt_matrix)
      MDMatrix.from_colt_matrix(result)
    end
        
    #------------------------------------------------------------------------------------
    # Constructs and returns the LU-decomposition of the given matrix.
    #------------------------------------------------------------------------------------
    
    def lu
      result = @colt_algebra.lu(@colt_matrix)
      [result.isNonsingular(), result.det(), result.getPivot.to_a(),
       MDMatrix.from_colt_matrix(result.getL()),
       MDMatrix.from_colt_matrix(result.getU())]
    end
            
    #------------------------------------------------------------------------------------
    # Returns the effective numerical rank of matrix A, obtained from Singular Value 
    # Decomposition.
    #------------------------------------------------------------------------------------
    
    def numerical_rank
      @colt_algebra.rank(@colt_matrix)
    end
        
    #------------------------------------------------------------------------------------
    # Linear algebraic matrix power; B = A^k <==> B = A*A*...
    #------------------------------------------------------------------------------------
    
    def power(val)
      result = @colt_algebra.pow(@colt_matrix, val)
      MDMatrix.from_colt_matrix(result)
    end
    
    alias :** :power
    
    #------------------------------------------------------------------------------------
    # Solves A*X = B
    #------------------------------------------------------------------------------------
    
    def solve(matrix)
      result = @colt_algebra.solve(@colt_matrix, matrix.colt_matrix)
      MDMatris.from_colt_matrix(resul)
    end
    
    #------------------------------------------------------------------------------------
    # Solves X*A = B, which is also A'*X' = B'.
    #------------------------------------------------------------------------------------
    
    def solve_transpose(matrix)
      result = @colt_algebra.solveTranspose(@colt_matrix, matrix.colt_matrix)
      MDMatris.from_colt_matrix(resul)
    end
    
    #------------------------------------------------------------------------------------
    # Constructs and returns the SingularValue-decomposition of the given matrix.
    #------------------------------------------------------------------------------------
    
    def svd
      result = @colt_algebra.svd(@colt_matrix)
      [result.getInfo().val, result.cond(), result.norm2(), result.rank(), 
       result.getSingularValues().to_a(),
       MDMatrix.from_colt_matrix(result.getS()),
       MDMatrix.from_colt_matrix(result.getU()),
       MDMatrix.from_colt_matrix(result.getV())]
    end
    
    #------------------------------------------------------------------------------------
    # Returns the sum of the diagonal elements of matrix A; Sum(A[i,i]).
    #------------------------------------------------------------------------------------
    
    def trace
      @colt_algebra.trace(@colt_matrix)
    end
    
    #------------------------------------------------------------------------------------
    # Constructs and returns a new view which is the transposition of the given matrix A.
    #------------------------------------------------------------------------------------
    
    def transpose
      MDMatrix.from_mdarray(@mdarray.transpose(0, 1))
    end
    
    #------------------------------------------------------------------------------------
    # Modifies the matrix to be a lower trapezoidal matrix.
    #------------------------------------------------------------------------------------
    
    def trapezoidal_lower
      result = @colt_algebra.trapezoidalLower(@colt_matrix)
      MDMatrix.from_colt_matrix(result)
    end
    
    #------------------------------------------------------------------------------------
    # Returns the two-norm (aka euclidean norm) of vector X.vectorize();
    #------------------------------------------------------------------------------------
    
    def vector_norm2
      @colt_algebra.vectorNorm2(@colt_matrix)
    end
    
  end # Matrix2dFloatingAlgebra


  ##########################################################################################
  #
  ##########################################################################################
  
  
  module Matrix2DDoubleAlgebra
    include_package "cern.colt.matrix.tdouble.algo"
    
    #------------------------------------------------------------------------------------
    # Constructs and returns the QR-decomposition of the given matrix.
    #------------------------------------------------------------------------------------
    
    def qr(economy_size = true)
      result = @colt_algebra.qr(@colt_matrix)
      [result.hasFullRank(), MDMatrix.from_colt_matrix(result.getQ(economy_size)),
       MDMatrix.from_colt_matrix(result.getR(economy_size))]
    end
    
  end
  
  ##########################################################################################
  #
  ##########################################################################################
  
  module Matrix2DFloatAlgebra
    include_package "cern.colt.matrix.tfloat.algo"
    
    #------------------------------------------------------------------------------------
    # Constructs and returns the QR-decomposition of the given matrix.
    #------------------------------------------------------------------------------------
    
    def qr
      result = @colt_algebra.qr(@colt_matrix)
      [result.hasFullRank(), 
       MDMatrix.from_colt_matrix(result.getH()),
       MDMatrix.from_colt_matrix(result.getQ()),
       MDMatrix.from_colt_matrix(result.getR())]
    end
    
  end
  
end # Colt


##########################################################################################
#
##########################################################################################

class DoubleMDMatrix1D

  include Colt::MatrixFloatingAlgebra

end

##########################################################################################
#
##########################################################################################

class DoubleMDMatrix2D

  include Colt::MatrixFloatingAlgebra
  include Colt::Matrix2DFloatingAlgebra
  include Colt::Matrix2DDoubleAlgebra

end

##########################################################################################
#
##########################################################################################

class FloatMDMatrix1D

  include Colt::MatrixFloatingAlgebra

end

##########################################################################################
#
##########################################################################################

class FloatMDMatrix2D

  include Colt::MatrixFloatingAlgebra
  include Colt::Matrix2DFloatingAlgebra
  include Colt::Matrix2DFloatAlgebra

end
