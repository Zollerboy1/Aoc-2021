var modelNumber = [Int](repeating: 1, count: 14)
modelNumber[10] = 9

var iterationCount = 0
while true {
    if iterationCount % 10_000_000 == 0 {
        print(iterationCount)
    }
    
    if iterationCount % 100_000_000 == 0 {
        print(modelNumber)
    }
    
    iterationCount += 1
    
    
    if modelNumber[4] + 4 == modelNumber[5]
        && modelNumber[6] + 3 == modelNumber[7]
        && modelNumber[9] + 8 == modelNumber[10] {
        var index = 0
        let nextDigit: () -> Int = {
            let value = modelNumber[index]
            index += 1
            return value
        }
        
        var w = 0
        var x = 0
        var y = 0
        var z = 0

        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 10
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 10
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 5
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 15
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 12
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -12
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 12
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 14
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 6
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -2
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 4
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 15
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -12
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 3
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 15
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 7
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 1
        x += 11
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 11
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -3
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 2
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 12
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -12
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 4
        y *= x
        z += y
        
        w = nextDigit()
        x *= 0
        x += z
        x %= 26
        z /= 26
        x += -13
        x = x == w ? 1 : 0
        x = x == 0 ? 1 : 0
        y *= 0
        y += 25
        y *= x
        y += 1
        z *= y
        y *= 0
        y += w
        y += 11
        y *= x
        z += y
        
        if z == 0 {
            break
        }
    }
    
    
    var indexToIncrement = 13
    modelNumber[indexToIncrement] += 1
    
    while modelNumber[indexToIncrement] == 10 {
        modelNumber[indexToIncrement] = 1
        
        indexToIncrement -= 1
        
        if indexToIncrement == 10 {
            indexToIncrement = 8
            modelNumber[indexToIncrement] += 1
        } else if indexToIncrement == 3 {
            modelNumber[indexToIncrement] += 1
            modelNumber[indexToIncrement - 1] += 1
        } else if indexToIncrement == 2 {
            modelNumber[indexToIncrement] = 1
            indexToIncrement -= 1
            modelNumber[indexToIncrement] += 1
        } else {
            modelNumber[indexToIncrement] += 1
        }
    }
}

print(modelNumber)
