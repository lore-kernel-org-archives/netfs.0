Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DDD3A0EA0
	for <netfs@lists.linux.dev>; Thu,  5 Feb 2026 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284753; cv=pass; b=fevDlPxm4Y5me+EeAmBFRZilIy+AK+dJnbMGJcu9AKlMSCmRVtb8IHeYCe3kLka6Z96yeXN6ujXD3H36ZzVlUwy+1qpY8wqFsP+xIOQhgjUq3yhegsbm0hEih3hSac0CUDQMRdWKNJov75AtjyexEz6TpoGpaNM7mDHxkCR9KQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284753; c=relaxed/simple;
	bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFsENoh4XI4q5jBQB3HDvxKMotvDVBnRiGnS1zUobp1DuSCw0VvclCKrtNQfvKhPqum2EBHzL61M40Tcz3spUbMPAlgLnmQmrB3RFlrWyRW+vggM7oiuz2w9BRARRDxaotMcHAizqeb0Ib1D5O8YcpWJOSJx0yCHIzT/bdkidu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apu3AEgM; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apu3AEgM"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-658b511573cso1299075a12.0
        for <netfs@lists.linux.dev>; Thu, 05 Feb 2026 01:45:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770284751; cv=none;
        d=google.com; s=arc-20240605;
        b=cDd1e8P994YqdmZa42YKKcpJRWP4qZ1RNSoCm7FoinY5fPg78rVJZfT8mJVyOEykPx
         7EHp3JuLsZoCMnpy8f3wdVNBNpAglt9+Sa4BY1b1bXlawQ4vDEv7QEBguRAHThOTkE6g
         G3PcMMZjz/ALOtQ6S6w+XW/X5+OuIYpUHl9RR45MyjSy0F42XSYeIkOqA7X+w7vbFGCd
         Ahgu2K+vgIyCJs9dfekjFnXOLfN9EqVduA4CnfgKttp9o2YhmGPJYMLgG+rCMxmxtcVN
         arz1WdW7GNECWLa6B7ccwjK9LWuksaouTEbI0YHpYw5Ur5uL0rZ+rOD0U14Wrjyk8BxB
         0Wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        fh=YetJpL0fydT0roOYD6yFWBDdKxh6hJx6EOEnnNQqUG8=;
        b=cEtY+8dIETo7pwh+ZVoN5IAZzWNiKDNWzhMSmKFDR7DtIyfImQFzQ+nu9D6ILC9E3k
         ODlIg0E0WvrIGCY4/MWyVW2XsNUs7Mb6x0Lqa+wPe/QfKBzk4Bl+hHRhapLvpONNHTBJ
         kCyQ++9EOp586WOspEhFEI8J8fBcjkKKPXpFsCxKqVP7Tv1jm/kqfWXjFkj62qaOdMHw
         +Czj0Z8cLZSkX6ktsCvWJX3SPmsLjKQowuXJxuQGD4MNIuU/d3jCNS1LLw7aTLfM9824
         bBqDk1Lj/xhhmpqd9qzQWziLJUS3CCNhmO/otEAbggXBotiuwoI7I+Sh6pCNsm1a+mXi
         Vhvw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770284751; x=1770889551; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=apu3AEgMQLGxEU2XdLsfZ9XanUovGb6U8ZGw2mkBn/Ay9iy1AHUOYT4LDAgJKg6W8q
         T91Hb+5QUNMrAtUxiHpY+FSW3feu50VjIfme86ySef+FCPYCZE7up0jWVbRoRH3Ty+c0
         q2gcGua9ajxRRacZ1CSU4YkY0FNof49qmiCTXEWgPQuI1cHtvrbSqtyjMe/C9lxYxwYr
         hP/cKfIPOOSaEatyN9/jhOmSKJMSbGQzQs2D9xXimDs2ieHgMrC5D6w4V97K4RVMS2gn
         L3SkS85YLb47vCQyOuPOdDdAgF3nF5DSDmnPN5rKHmOeWnCOXTv6PRGvLRU91ViPqhJv
         7c9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284751; x=1770889551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gTHjRNg48uqIhlFUjNVy6w29gFOiVNhUd1etS9WljNU=;
        b=rIwO7vI7mEjjtCaRDFIheYls72ZiOa/lIOzCGPv2ArvnbKAIZrNkIkAtFM+nMSIGQE
         Ot0V71hQLJgVHTYss1Xg88til2yfLwBwUIqsFS+Fo5DnSEqZfQGQkLCt/GUi3cQYaZhK
         xVQE826SS7TZNI/LHtjn5nlvl9J2VTbTXFNdINrLWnsamhqkL0NLcwzhV7DGTw0mxMvN
         wyjALFqFyfLMS0A9mxwexQuoVat9pbAZyaf1VG8dKq/sTsXkA76ZR11ll7gzjekaU7mh
         hoQI+1tW+8Rw64yxjOBRFyIzBxmLVwSa+AqXuVZjHE+VauT9GLG4PFQeg71/MwdGZUUC
         j5kQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5+zHB3RQ8atZz1IJfZpqQblRgyqdxV4Ubd9+LAwLwh0J18fWZCCUjUYzwPVFZMP6N3pID/g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9iBIUDMsn81TeINJq5muuN0QagiK7dg229eciGANiKDLiLbiW
	FfnVDtd3iUyMHd7he3Exbq2tOnaAX0uamRV4sDxe7Se40IKvsD4oR/3GhFUgkeob5K30yXfbBLB
	hngX7mjHPAa8WPBF62SlipQeO9b5r9mM=
X-Gm-Gg: AZuq6aIJXlaAT3sYQDfQJ8odRKLW1wFWX+aE239k45jq5jTBtePQcPbTvVRDAPaRjJg
	lWqhxUWVC+XncguYWJdnhPKmKzxHD4iVW0G93UZEZenowdxzEKmlglecbXrVWrYp2rixFDehKco
	IUPUhF7sZnWJP2PJ7+L977tv6/5fXoSQlex6t1N+Z/q5dZivB8G1R8Kzrjf+Iml6BiFYJNP5olt
	WBZExTH9Wwpfgb2q2RJLbSo/BFRgtCU1PLx3oqpXQrdFoccU4IGamWTZtxrQqWo9Fv5X/C98iOh
	nNZOs3ndKjTi8NkV5L91Zfcj0ys17g==
X-Received: by 2002:a17:907:7f92:b0:b87:31d1:4131 with SMTP id
 a640c23a62f3a-b8e9f64603cmr435430866b.60.1770284751163; Thu, 05 Feb 2026
 01:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260204050726.177283-1-neilb@ownmail.net> <20260204050726.177283-13-neilb@ownmail.net>
In-Reply-To: <20260204050726.177283-13-neilb@ownmail.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 5 Feb 2026 10:45:38 +0100
X-Gm-Features: AZwV_Qg7CM-kXxjB2Qin-euJkaOUd7ni190R_n_ZLhun34eHr5T-i9uF6CbqXdo
Message-ID: <CAOQ4uxi3bNYq1b4=qL-JLi19hRwurntfLZXhUMVL003NarBdGg@mail.gmail.com>
Subject: Re: [PATCH 12/13] ovl: remove ovl_lock_rename_workdir()
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 6:09=E2=80=AFAM NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> This function is unused.
>

I am confused.
What was this "fix" fixing an unused function:

e9c70084a64e5 ovl: fail ovl_lock_rename_workdir() if either target is unhas=
hed

What am I missing?

Otherwise, feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
