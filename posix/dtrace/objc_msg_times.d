objc$target:::entry
{
  self->start = timestamp;
}

objc$target:::return
/self->start/
{
  @ = quantize(timestamp - self->start);
  self->start = 0;
}