Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC25217F4E
	for <netfs@lists.linux.dev>; Sat, 26 Oct 2024 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729904471; cv=none; b=qxra0fFM1UrghenWGu55g03MgPBc/ZL+RBC/fQ0Id9krfZvwCLP3Gw5iMKBvgUb17fkkDp4sZ9WnO/7P0JmvFQuhFJqntorOCN3+eoPgp3c61NEQ0T05DwddSfKeKlk3h/J70Ei/NYvVP/fFakzQcIZ45MYIWN/AFuWwQhZgkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729904471; c=relaxed/simple;
	bh=74naCgbzblilLVmg2wQT4pdyCk+BiN3JSv/pOpMQSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj7iOyICwrKvZcSiS9Onavzf5r+ZAAuUFL3K5ux8cqoUVkaC48WfGVzesU07D6+bKQOemimc9AzxJ1fVXjJ7OQJn+QE03G4wdKnhxn0Ok+PZwXt3QAPRuCBqD6wcptB8JYcYq6XJZKcowPSfk2BiKbbMNFoeMhHHZ48Z8dFCUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhufj3Y4; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhufj3Y4"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7203c74e696so1871713b3a.0
        for <netfs@lists.linux.dev>; Fri, 25 Oct 2024 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729904469; x=1730509269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kp+8rpGshAmIc76TzwqKIgLwwjDzh58oBtEsaBWEayc=;
        b=Bhufj3Y4LlxkezPnEF/TXreJEXht7n69kTS3x7oLtwABCMt7BhEG7BR9boUOzdqrLp
         lvPZ5/2YqJn+CQ3myvp0jFveHUSA7Pwpmfmof0B3ZMpNQF/WllowUP0OX0DR5u+9bgMP
         SPV9MxvC2aKAIr4y6eZpkfi628Uu5tjYjk00qoQ6/koYYodKamMPAGAHT84TTLfEVHR+
         6hG9N+/RDhxrbzpZDGwUAQKbJstU84RTPn3NVlOgVonC+53c9ESLUHv3f2X2eKbUmxaI
         9/etPQYCyBNntnpcesbMzptCs/tDwHGIrtF6FmsMJAn0ALJ0ynUfuEBRECBrS19E1H76
         J8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729904469; x=1730509269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp+8rpGshAmIc76TzwqKIgLwwjDzh58oBtEsaBWEayc=;
        b=ps+sk6ERHgKhXW8hj0l63lLRrggnrYjcJk2neJw7Jv4o2G0azmSfpX5GdCv9fJw+ky
         tR/c4ZCzwTjG7PXrOpieGMTqxgw5h3AIL11kjaC8O+U5IYi/60k8ebvs+dCUTbFV9t9/
         zeXXLaCSZJg/lVN7fkWwabAcuIh5pcCIQ8dgdrb0so5u+PeFLHPPSZtP520EYsKLPXem
         3NdpJSWYVQikKuSZfcxfQ78pvWuVNTq7gML+gBpgmovUq9UDJ31if6BDPCflM6za4zYN
         xCNm/OuhogUj5Q2ZhIV2eK9TlxCxQVLOrKmpq0Ewf30kBht0hGyIGxjD0d2DkSeXH+yf
         svOg==
X-Forwarded-Encrypted: i=1; AJvYcCXMmrkhsPPuGR2ZeHo3FS74eH5rGsY9Y8+9r8nRXojM3HVqD7ESf2bj6rT1goo9OXsKrwO1Dg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpU96A2OMMgWsygMcP919vyA6zbrGiJOYX3u+RUpjxz2zY5Jtn
	Q13a1KuufNBVbWCim4719JljN/d7C1+jKas5e24Ly9/BvKiSOvC6
X-Google-Smtp-Source: AGHT+IFS9p5Ie6Pnt4Z3FtjjRose2pRphMsKXMbqemvY6B1XjtckJ8+MzcaKx5TFNSfJKuhYpk67oQ==
X-Received: by 2002:aa7:870d:0:b0:71e:7604:a76 with SMTP id d2e1a72fcca58-72062f865a6mr1796148b3a.1.1729904468749;
        Fri, 25 Oct 2024 18:01:08 -0700 (PDT)
Received: from gmail.com ([24.130.68.0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc89ffb51sm1734781a12.63.2024.10.25.18.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 18:01:08 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:01:06 -0700
From: Chang Yu <marcus.yu.56@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, jlayton@kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] netfs: Add a check for NULL folioq in
 netfs_writeback_unlock_folios
Message-ID: <Zxw_UgtVWOHHfkoD@gmail.com>
References: <ZxshMEW4U7MTgQYa@gmail.com>
 <3951592.1729843553@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3951592.1729843553@warthog.procyon.org.uk>

On Fri, Oct 25, 2024 at 09:05:53AM +0100, David Howells wrote:
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > syzkaller reported a null-pointer dereference bug
> > (https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16) in
> > netfs_writeback_unlock_folios caused by passing a NULL folioq to
> > folioq_folio. Fix by adding a check before entering the loop.
> 
> And, of course, the preceding:
> 
> 	if (slot >= folioq_nr_slots(folioq)) {
> 
> doesn't oops because it doesn't actually dereference folioq.
> 
> However... if we get into this function, there absolutely *should* be at least
> one folioq in the rolling buffer.  Part of the rolling buffer's method of
> operation involves keeping at least one folioq around at all times so that we
> don't need to use locks to add/remove from the queue.
> 
> Either the rolling buffer wasn't initialised yet (and it should be initialised
> for all write requests by netfs_create_write_req()) or it has been destroyed
> already.
> 
> Either way, your patch is, unfortunately, just covering up the symptoms rather
> than fixing the root cause.  I suggest instead that we patch the function to
> detect the empty rolling buffer up front, dump some information about the bad
> request and return.
> 
> David
> 
I see. This might be a stupid question, but is it ever possible that we have
exactly one folioq and at the same time

        slot >= folioq_nr_slots(folioq)

is true? Then I imagine netfs_delete_buffer_head would return NULL and
cause the bug to trigger as well?
