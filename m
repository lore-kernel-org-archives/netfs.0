Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEDB28469A;
	Sat, 11 Oct 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760211644; cv=none; b=lrkXtmz3hTify99fKY8PAx97vyiiDcUV67xn43BBeqak+RJkAW9M0/1y1ETOOJXN1v1u0A4dO1hTKQskAlxVpmjaPhSCxtvqIgUMxC8toLJryr4Hx2x8o9ermgRHCHtQQ9noK3CHZCGTOmVTPE2Ot9sHJLHLtoUv0vdixPi35p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760211644; c=relaxed/simple;
	bh=l6PfjANfUpBtaN0fS4GZaMfa9JZ+uJ9pMscD9Z98sNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNnqpPAVzoZIscH0kLMRHlDL81fa8OXXnu/40/BCDtCWQ9eZFDJLZNc2Wn8hsKmtyM5ecN9eR2YzneCWxhToqagtarZ1RILm4ndrbEfR8XWId7qXf/UfzDJfVbCl0pT5Sc11Q051WAVdUTcOTnOz9ICdyel2afH2xlNwVUJ5wfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=HQe5kHc1; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="HQe5kHc1"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id F0BA314C2D3;
	Sat, 11 Oct 2025 21:40:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760211633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLEV4E8ZPaERjqSqpcXc1T1WbVXZeBg8LghWOpCBdv8=;
	b=HQe5kHc1ymePtuKmO36tA/3PYgqJ7bIeEonDAy0MLRVl2NaRDt+QA1vkx7axRnVkj78vJq
	AJEi1x8zKyeOmZe2X6LtW7DAR/A7G+ChRa16CrEr6w/EMb08shh156CkyE4s8zJbOqb1Ye
	DvVYZIV5hR6ffU2qmmG3BapQaMAA8wVYjNJA5UpaiyA/1b9QXwJK9P0SJW51bAXnAQlk9Y
	2rUVOb0eT2sLeb1Lx7DqNv50qvQSGd4jsc950Hy1z4iOm1qcAtIgb8fVcjyiwgOa0ObekZ
	Tw91s8UKGNv5fdE4Oqy1fxMWD0jw8OKWIN+qSip4Nk7aPKauBywxSyt1hyV5yg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 3e2783d9;
	Sat, 11 Oct 2025 19:40:29 +0000 (UTC)
Date: Sun, 12 Oct 2025 04:40:14 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Tingmao Wang <m@maowtm.org>
Cc: v9fs@lists.linux.dev, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: -ENODATA from read syscall on 9p
Message-ID: <aOqynl8t6_KvUlM0@codewreck.org>
References: <hexeb4tmfqsugdy442mkkomevnhjzpuwtsslypeo3lnbbtmpmk@ibrapupausp7>
 <da9b0573-506a-4ce3-88f3-b1714b32db5f@maowtm.org>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <da9b0573-506a-4ce3-88f3-b1714b32db5f@maowtm.org>

Tingmao Wang wrote on Sat, Oct 11, 2025 at 03:35:00PM +0100:
> Not a 9pfs maintainer here, but I think I have encountered this in the
> past but I didn't think too much of it.  Which kernel version are you
> testing on?  A while ago I sent a patch to fix some stale metadata
> issue on uncached 9pfs, and one of the symptom was -ENODATA from a read:
> https://lore.kernel.org/all/cover.1743956147.git.m@maowtm.org/
> 
> Basically, if some other process has a 9pfs file open, and the file
> shrinks on the server side, the inode's i_size is not updated when another
> process tries to read it, and the result is -ENODATA (instead of reporting
> a normal EOF).
> 
> Does this sound like it could be happening in your situation?  This patch
> series should land in 6.18, so if this was not reproduced on -next it
> might be worth a try?

It got merged in yesterday


With that said I'm also curious if that's the reason 9p reads stopped
progressing, but even with this patch I think there'd be a window for
files to shrink while the read is happening so netfs needs to return a
short read anyway -- if the file really is being modified under us it's
possible to hit end of file early.

OTOH I don't think that's what's happening here though, as Kent is
likely just running xfstest on its own in a directory...
You says these errors just started happening recently?
How recently are you talking?
I doubt it's been months but the only recent changes I see in this area
would be the netfs i_size updating patches early July.. If it's more
recent than that there's something else I didn't see anything obvious,
having a rough range to look at would be welcome for closer inspection.

-- 
Dominique Martinet | Asmadeus
