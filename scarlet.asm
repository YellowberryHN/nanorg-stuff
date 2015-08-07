info: scarlet.asm, Anonymous

main:
	// select a random direction and distance to move
        rand    [dir], 4
        rand    [count], 5 //edit
        add     [count], 1 //edit

loop:
	// check if I'm top of food and eat if so
        sense   r2
        jns     noFood
        eat

noFood:
   
        // see if we're over a collection point and
        // release some energy
        energy  r9
        div     r9, 2
        cmp     r9, 2000
        jl      notEnufEnergy
        sense   r5
        cmp     r5, 0xFFFF      // are we on a colleciton point?
        jne     notEnufEnergy
        getxy   r12, r13        // remember the location of this collection point.
        sub     r9, 6
        release r9 //edit             // drain my energy by 500, but get 500 points, assuming
                                // that we're releasing on a collection point

notEnufEnergy:
	// move me
        cmp     [count], 0      // moved enough in this direction; try a new one
        je      newDir
        travel  [dir]
        jns     sayHello		// bumped into another org or the wall
        sub     [count], 1

        jmp     loop

sayHello:                       // (appears to) corrupts the memory of the drones
        mov     r0, [dir]
        poke    [dir], 10
        jns     newDir
        charge  [dir], 100
        //poke    [dir], 40
        //poke    [dir], 50
        //poke    [dir], 60
        //poke    [dir], 70
        //poke    [dir], 80
        //poke    [dir], 90
        //poke    [dir], 100
        
newDir:
        rand    [dir], 4        // select a new direction
        jmp     move
        
move:
	// select a random direction and distance to move
        rand    [count], 5 //edit
        add     [count], 1 //edit
        jmp     loop
        
dir:				
        data { 0 }       // our initial direction

count:                   // our initial count of how far to move in the cur dir
        data { 0 }
